---   ██████╗   ██████╗    ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
--- ██╔═════╝ ██╔═════╝    ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
--- ██║       ██║          ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
--- ██║       ██║          ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
--- ╚═██████╗ ╚═██████╗    ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
---   ╚═════╝   ╚═════╝    ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
--- Project : cc_delete_vehicle
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
    Commands = {
        'delallcar',
        'dvall'
    },
    Group = 'superadmin',
    AllowConsole = true,
    HelpMessage = 'คำสั่ง ลบรถทุกคันที่ไม่มีคนขับ',
    arguments = {
        {
            name = 'minute',
            help = 'กรุณาใส่นาทีนับถอยหลังลบรถ',
            type = 'number' }
    }
}

Config.CanCelDelete = {
    Commands = {
        'ccdelallcar',
        'ccdvall'
    },
    AllowConsole = true,
    Group = 'superadmin',
    HelpMessage = 'คำสั่ง ยกเลิกคำสั่งการลบรถ',
}