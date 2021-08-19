fx_version 'cerulean'
game 'gta5'

author 'ANTOND.#8507'
description 'Simple switchjob script.'
version '1.0.0'

client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

shared_scripts {
	'@es_extended/imports.lua',
	'config.lua'
}