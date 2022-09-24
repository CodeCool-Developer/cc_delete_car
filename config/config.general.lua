---   ██████╗   ██████╗    ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
--- ██╔═════╝ ██╔═════╝    ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
--- ██║       ██║          ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
--- ██║       ██║          ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
--- ╚═██████╗ ╚═██████╗    ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
---   ╚═════╝   ╚═════╝    ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
--- Project : cc_delete_car
--- Auth : CodeCool Developer
--- Website : https://fivem.codecool.xyz
--- Discord : https://discord.gg/K7PDe2jfpW

script_name = GetCurrentResourceName()

Config = {}
Config.EventRoute = {
    ['getSharedObject'] = 'esx:getSharedObject', -- Default: 'esx:getSharedObject'
}

Config.SoundNotify = {
    { time = 10, file = 'delcars1', volume = 0.2 },
    { time = 3, file = 'delcars2', volume = 0.2 },
    { time = 1, file = 'delcars3', volume = 0.2 },
    { time = 0, file = 'delcars4', volume = 0.2 }
}

Config.Timer = {
    { "02:50", 10 },
    { "04:50", 10 },
    { "06:50", 10 },
    { "08:50", 10 },
    { "10:50", 10 },
    { "12:50", 10 },
    { "14:50", 10 },
    { "16:50", 10 },
    { "18:50", 10 },
    { "20:50", 10 },
    { "22:50", 10 },
}

Config.DeleteAllVehicle = {
    command = 'delallcar',
    group = {
        ['superadmin'] = true,
        ['admin'] = true,
    },
}

Config.CanCelDeleteAllVehicle = {
    command = 'ccdelallcar',
    group = {
        ['superadmin'] = true,
        ['admin'] = true,
    },
}