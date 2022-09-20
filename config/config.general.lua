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

Config.Timer = {
    { "02:55", 5 },
    { "04:55", 5 },
    { "06:55", 5 },
    { "08:55", 5 },
    { "10:55", 5 },
    { "12:55", 5 },
    { "14:55", 5 },
    { "16:55", 5 },
    { "18:55", 5 },
    { "20:55", 5 },
    { "22:55", 5 },
    { "00:55", 5 },
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