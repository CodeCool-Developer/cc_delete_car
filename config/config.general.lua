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

Config.SoundNotifyDeleteVehicle = {
    { time = 10, file = 'delcar10', volume = 0.2 },
    { time = 3, file = 'delcar3', volume = 0.2 },
    { time = 1, file = 'delcar1', volume = 0.2 },
    { time = 0, file = 'delcar0', volume = 0.2 }
}

Config.SoundNotifyRestartServer = {
    --{ time = 10, file = 'restart1', volume = 0.2 },
    --{ time = 3, file = 'restart2', volume = 0.2 },
    --{ time = 1, file = 'restart3', volume = 0.2 },
    --{ time = 0, file = 'restart4', volume = 0.2 }
}

Config.TimerDeleteVehicle = {
    { '04:00', 10, 'delcar' },
    { '09:00', 10, 'delcar' },
    { '14:00', 10, 'delcar' },
    { '20:00', 10, 'delcar' },
    { '23:00', 10, 'delcar' },

    { '14:41', 1, 'restart' },
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

Config.RunRestartNotify = {
    command = 'rsnoti',
    group = {
        ['superadmin'] = true,
        ['admin'] = true,
    },
}

Config.CanCelRestartNotify = {
    command = 'ccrsnoti',
    group = {
        ['superadmin'] = true,
        ['admin'] = true,
    },
}