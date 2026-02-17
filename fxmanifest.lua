fx_version 'cerulean'
game 'gta5'

author 'UnixLib'
version '1.0.0'
description 'Unix FiveM Library - Auto-detecting framework abstraction'

lua54 'yes'

client_scripts {
    'utils/**/*.lua',
    'shared/**/*.lua',
    'client/**/*.lua',
}

server_scripts {
    'utils/**/*.lua',
    'shared/**/*.lua',
    'server/**/*.lua',
}

files {
    'locales/*.json',
}
