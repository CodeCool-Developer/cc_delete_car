ESX = nil

local isCountDownDeleteCar = false
local isCountDownRestartServer = false
local lastTimePlaySound = nil
local endSound = nil

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

RegisterNetEvent(script_name .. ':CancelNotifyDeleteVehicle')
AddEventHandler(script_name .. ':CancelNotifyDeleteVehicle', function()
    isCountDownDeleteCar = false
    SendNUIMessage({ ShowMenu = false, })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    SendNUIMessage({
        transactionType = 'stopSound',
    })
end)

RegisterNetEvent(script_name .. ':CancelNotifyRestartServer')
AddEventHandler(script_name .. ':CancelNotifyRestartServer', function()
    isCountDownRestartServer = false
    SendNUIMessage({ ShowMenu = false, })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    SendNUIMessage({
        transactionType = 'stopSound',
    })
end)

function playSound(soundNotify)
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = soundNotify.file,
        transactionVolume = soundNotify.volume
    })
end

RegisterNetEvent(script_name .. ':RunNotifyDeleteVehicle')
AddEventHandler(script_name .. ':RunNotifyDeleteVehicle', function(_times)
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

            local min = tonumber(txtMin) + 1
            if lastTimePlaySound ~= tonumber(min) then
                lastTimePlaySound = min
                for k, v in pairs(Config.SoundNotifyDeleteVehicle) do
                    if min == v.time then
                        playSound(v)
                    end
                end
            end

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
                    -- ค้นหาเสียงสุดท้ายตอนนับเวลาจบว่ามีหรือไม่
                    for k, v in pairs(Config.SoundNotifyDeleteVehicle) do
                        if v.time == 0 then
                            endSound = v
                            break
                        end
                    end

                    if endSound ~= nil then
                        playSound(endSound)
                    end
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
                    lastTimePlaySound = nil
                    SendNUIMessage({ display = false, })
                end
            end
        end
    end)
end)

RegisterNetEvent(script_name .. ':RunNotifyRestartServer')
AddEventHandler(script_name .. ':RunNotifyRestartServer', function(_times)
    isCountDownRestartServer = true

    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    local times = _times * 60
    local matchTime = ESX.Round(times)
    Citizen.CreateThread(function()
        while matchTime > 0 and isCountDownRestartServer do
            Citizen.Wait(1000)
            if matchTime > 0 then
                matchTime = matchTime - 1
            end

            local txtMin = ('%s'):format(minToClock(matchTime))
            local txtSec = ('%s'):format(secToClock(matchTime))

            local min = tonumber(txtMin) + 1
            if lastTimePlaySound ~= tonumber(min) then
                lastTimePlaySound = min
                for k, v in pairs(Config.SoundNotifyRestartServer) do
                    if min == v.time then
                        playSound(v)
                    end
                end
            end

            if isCountDownRestartServer then
                SendNUIMessage({
                    display = true,
                    IsPauseMenuActive = IsPauseMenuActive(),
                    titleText = 'ระบบรีสตาร์ทเซิร์ฟเวอร์',
                    subText = 'กรุณาออกจากเซิร์ฟเวอร์ในเวลาที่กำหนด',
                    txtMin = txtMin,
                    txtSec = txtSec,
                })

                if matchTime == 0 then
                    -- ค้นหาเสียงสุดท้ายตอนนับเวลาจบว่ามีหรือไม่
                    for k, v in pairs(Config.SoundNotifyRestartServer) do
                        if v.time == 0 then
                            endSound = v
                            break
                        end
                    end

                    if endSound ~= nil then
                        playSound(endSound)
                    end
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
                    isCountDownRestartServer = false
                    lastTimePlaySound = nil
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