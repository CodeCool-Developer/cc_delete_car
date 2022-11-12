ESX = nil
local timer = 0
local isEventStart = false
local EventName = nil

TriggerEvent(Config.EventRoute['getSharedObject'], function(obj)
    ESX = obj
end)

-------------------------------------------------------
--- Register Commands เริ่มนับเวลาถอยหลังแจ้งเตือนลบรถอัตโนมัติ ---
-------------------------------------------------------
RegisterCommand(Config.DeleteAllVehicle.command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.DeleteAllVehicle.group[xPlayer.getGroup()] then
        if args[1] ~= nil and not isEventStart then
            local minute = args[1]
            TriggerClientEvent(script_name .. ":RunNotifyDeleteVehicle", -1, minute)
            checkTimeLoad(minute, 'delcar')
        end
    end
end)

-----------------------------------------------------------
--- Register Commands ยกเลิกการนับเวลาถอยหลังแจ้งเตือนลบรถอัตโนมัติ ---
-----------------------------------------------------------
RegisterCommand(Config.CanCelDeleteAllVehicle.command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.DeleteAllVehicle.group[xPlayer.getGroup()] then
        isEventStart = false
        timer = 0
        TriggerClientEvent(script_name .. ":CancelNotifyDeleteVehicle", -1)
    end
end)

------------------------------------------------------------
--- Register Commands เริ่มนับเวลาถอยหลังแจ้งเตือน restart server ---
------------------------------------------------------------
RegisterCommand(Config.RunRestartNotify.command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.RunRestartNotify.group[xPlayer.getGroup()] then
        if args[1] ~= nil and not isEventStart then
            local minute = args[1]
            TriggerClientEvent(script_name .. ":RunNotifyRestartServer", -1, minute)
            checkTimeLoad(minute, 'restart')
        end
    end
end)

-----------------------------------------------------------------
--- Register Commands ยกเลิกการนับเวลาถอยหลังแจ้งเตือน restart server ---
-----------------------------------------------------------------
RegisterCommand(Config.CanCelRestartNotify.command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.CanCelRestartNotify.group[xPlayer.getGroup()] then
        isEventStart = false
        Citizen.Wait(2000)
        timer = 0
        TriggerClientEvent(script_name .. ":CancelNotifyRestartServer", -1)
    end
end)

RegisterServerEvent(script_name .. ':CheckEventTime')
AddEventHandler(script_name .. ':CheckEventTime', function()
    if isEventStart then
        if EventName == 'delcar' then
            TriggerClientEvent(script_name .. ':RunNotifyDeleteVehicle', source, timer / 60)
        elseif EventName == 'restart' then
            TriggerClientEvent(script_name .. ':RunNotifyRestartServer', source, timer / 60)
        end
    end
end)

function checkTimeLoad(xTime, xEventName)
    timer = xTime * 60
    isEventStart = true
    EventName = xEventName
    Citizen.CreateThread(function()
        while isEventStart do
            Citizen.Wait(1000)
            if timer == 0 then
                if EventName == 'restart' then
                    local xPlayers = ESX.GetPlayers()
                    for k, user in pairs(xPlayers) do
                        DropPlayer(user, 'รีเซิร์ฟนะอิอิ') -- TODO เปลี่ยนคำ
                    end
                end
                isEventStart = false
                EventName = nil
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
                    if Config.Timer[i][3] == 'delcar' then
                        TriggerClientEvent(script_name .. ':RunNotifyDeleteVehicle', -1, Config.Timer[i][2])
                        checkTimeLoad(Config.Timer[i][2], Config.Timer[i][3])
                    elseif Config.Timer[i][3] == 'restart' then
                        TriggerClientEvent(script_name .. ':RunNotifyRestartServer', -1, Config.Timer[i][2])
                        checkTimeLoad(Config.Timer[i][2], Config.Timer[i][3])
                    end
                end
            end
        end
        checkTimeRunAuto()
    end)
end

checkTimeRunAuto()