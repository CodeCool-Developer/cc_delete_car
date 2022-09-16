ESX = nil

local isCountDownDeleteCar = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.EventRoute['getSharedObject'], function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent(script_name .. ':CheckEventTime')
end)

RegisterNetEvent(script_name .. ':CancelDeleteCar')
AddEventHandler(script_name .. ':CancelDeleteCar', function()
    isCountDownDeleteCar = false
    SendNUIMessage({ ShowMenu = false, })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end)

RegisterNetEvent(script_name .. ':deleteCar')
AddEventHandler(script_name .. ':deleteCar', function(_times)
    isCountDownDeleteCar = true

    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    local times = _times * 60
    local matchTime = ESX.Round(times)
    Citizen.CreateThread(function()
        while matchTime > 0 and isCountDownDeleteCar do
            Citizen.Wait(1000)
            if matchTime > 0 then
                matchTime = matchTime - 1
            end

            local txtMin = ('%s'):format(minToClock(matchTime))
            local txtSec = ('%s'):format(secToClock(matchTime))

            if isCountDownDeleteCar then
                SendNUIMessage({
                    display = true,
                    IsPauseMenuActive = IsPauseMenuActive(),
                    titleText = 'ระบบลบรถอัตโนมัติ',
                    subText = 'ขึ้นรถภายในเวลา มิเช่นนั้นรถคุณจะถูกลบ',
                    txtMin = txtMin,
                    txtSec = txtSec,
                })

                if matchTime == 0 then
                    local gameVehicles = ESX.Game.GetVehicles()
                    for i = 1, #gameVehicles do
                        local vehicle = gameVehicles[i]
                        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
                            SetVehicleHasBeenOwnedByPlayer(vehicle, false)
                            SetEntityAsMissionEntity(vehicle, false, false)
                            Citizen.CreateThread(function()
                                while DoesEntityExist(vehicle) do
                                    Citizen.Wait(1000)
                                    ESX.Game.DeleteVehicle(vehicle)
                                end
                            end)
                        end
                    end
                    isCountDownDeleteCar = false
                    SendNUIMessage({ display = false, })
                end
            end
        end
    end)
end)

function secondsToClock(seconds)
    local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

    if seconds <= 0 then
        return 0, 0
    else
        local hours = string.format("%02.f", math.floor(seconds / 3600))
        local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

        return mins, secs
    end
end

function minToClock(seconds)
    local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

    if seconds <= 0 then
        return 0, 0
    else
        local hours = string.format("%02.f", math.floor(seconds / 3600))
        local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

        return mins
    end
end

function secToClock(seconds)
    local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

    if seconds <= 0 then
        return 0, 0
    else
        local hours = string.format("%02.f", math.floor(seconds / 3600))
        local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

        return secs
    end
end