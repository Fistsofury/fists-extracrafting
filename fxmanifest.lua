fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'
version '1.0'
author 'Fistsofury'

client_scripts { 
    'client/client.lua',
}

shared_scripts {
    'config.lua',
}

files {
    'html/html.html',
    'html/css/styles.css',
    'html/js/js.js'
}

ui_page 'html/html.html'

server_scripts {
    'server/server.lua',
}
