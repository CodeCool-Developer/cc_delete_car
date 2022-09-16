fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'
description 'CC Delete Car'
author 'CodeCool Developer'

ui_page "client/html/index.html"

files {
    "client/html/index.html",
    "client/html/js/*.js",
    "client/html/css/*.css",
}

shared_script {
    'config/config.general.lua',
}

client_scripts {
    'client/main.lua',
}

server_script {
    'server/main.lua',
}