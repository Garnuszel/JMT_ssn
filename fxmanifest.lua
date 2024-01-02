fx_version 'cerulean'
game 'gta5'


author 'Garnuhhh'

lua54 'yes'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua'
}


shared_scripts {
    '@es_extended/imports.lua'
}