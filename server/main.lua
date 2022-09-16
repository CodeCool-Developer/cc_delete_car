ESX = nil
local timer = 0
local isEventStart = false

TriggerEvent(Config.EventRoute['getSharedObject'], function(obj)
    ESX = obj
end)

------------------------------------------------
--- Register Commands เริ่มนับเวลาถอยหลังลบรถอัตโนมัติ ---
------------------------------------------------
ESX.RegisterCommand(Config.DeleteAllVehicle.Commands, Config.DeleteAllVehicle.Group, function(xPlayer, args, showError)
    local minute = args.minute
    TriggerClientEvent(script_name .. ":deleteCar", -1, minute)
    checkTimeLoad(minute, 'delallcar')
end, true, {
    help = Config.DeleteAllVehicle.HelpMessage,
    validate = Config.DeleteAllVehicle.allowConsole,
    arguments = Config.DeleteAllVehicle.arguments
})

-----------------------------------------------------
--- Register Commands ยกเลิกการนับเวลาถอยหลังลบรถอัตโนมัติ ---
-----------------------------------------------------
ESX.RegisterCommand(Config.CanCelDelete.Commands, Config.DeleteAllVehicle.Group, function(xPlayer, args, showError)
    timer = 0
    isEventStart = false
    TriggerClientEvent(script_name .. ":CancelDeleteCar", -1)
end, true, {
    help = Config.DeleteAllVehicle.HelpMessage,
    validate = Config.DeleteAllVehicle.allowConsole
})

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
        local date_local = os.date('%H:%M:%S', os.time())
        for i = 1, #Config.Timer, 1 do
            local start_time = Config.Timer[i][1] .. ':00'
            if date_local == start_time then
                if Config.Timer[i][2] == "delallcar" then
                    TriggerClientEvent(script_name .. ':deleteCar', -1, Config.Timer[i][3])
                    checkTimeLoad(Config.Timer[i][3])
                end
            end
        end
        checkTimeRunAuto()
    end)
end

checkTimeRunAuto()