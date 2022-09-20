ESX = nil
local timer = 0
local isEventStart = false

TriggerEvent(Config.EventRoute['getSharedObject'], function(obj)
    ESX = obj
end)

------------------------------------------------
--- Register Commands เริ่มนับเวลาถอยหลังลบรถอัตโนมัติ ---
------------------------------------------------
RegisterCommand(Config.DeleteAllVehicle.command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.DeleteAllVehicle.group[xPlayer.getGroup()] then
        local minute = args[1]
        TriggerClientEvent(script_name .. ":deleteCar", -1, minute)
        checkTimeLoad(minute, 'delallcar')
    end
end)

-----------------------------------------------------
--- Register Commands ยกเลิกการนับเวลาถอยหลังลบรถอัตโนมัติ ---
-----------------------------------------------------
RegisterCommand(Config.CanCelDeleteAllVehicle.command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.DeleteAllVehicle.group[xPlayer.getGroup()] then
        timer = 0
        isEventStart = false
        TriggerClientEvent(script_name .. ":CancelDeleteCar", -1)
    end
end)

RegisterServerEvent(script_name .. ':CheckEventTime')
AddEventHandler(script_name .. ':CheckEventTime', function()
    if isEventStart then
        TriggerClientEvent(script_name .. ':deleteCar', source, timer / 60)
    end
end)

function checkTimeLoad(xTime)
    timer = xTime * 60
    isEventStart = true
    Citizen.CreateThread(function()
        while isEventStart do
            Citizen.Wait(1000)
            if timer == 0 then
                isEventStart = false
            end
            timer = timer - 1
        end
    end)
end

function checkTimeRunAuto()
    SetTimeout(1000, function()
        local date_local = os.date('%H:%M', os.time())
        if not isEventStart then
            for i = 1, #Config.Timer, 1 do
                local start_time = Config.Timer[i][1]
                if date_local == start_time then
                    TriggerClientEvent(script_name .. ':deleteCar', -1, Config.Timer[i][2])
                    checkTimeLoad(Config.Timer[i][2])
                end
            end
        end
        checkTimeRunAuto()
    end)
end

checkTimeRunAuto()