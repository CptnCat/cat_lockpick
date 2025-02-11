fx_version 'cerulean'
game 'gta5'

author 'EpicCat'
description 'Lockpick Script'
version '1.1.1'
repository 'https://github.com/CptnCat/cat_lockpick'

lua54 'yes'

shared_scripts { 
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client.lua'

server_script 'server.lua'

dependencies {
    'ox_lib'
}
