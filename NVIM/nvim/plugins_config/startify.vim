let g:startify_session_dir = '~/.config/nvim/session'


let g:startify_lists = [
	\ { 'type': 'files',     'header': ['   Recent Files']            },
	\ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
	\ { 'type': 'sessions',  'header': ['   Sessions']       },
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ { 'type': 'commands',  'header': ['   Commands']       },
	\ ]


let g:startify_custom_header = [
	\ ' _____   ______        ______           _____     ____      ____  ____      ______  _______   ',
	\ '|\    \ |\     \   ___|\     \     ____|\    \   |    |    |    ||    |    |      \/       \  ',
	\ ' \\    \| \     \ |     \     \   /     /\    \  |    |    |    ||    |   /          /\     \ ',
	\ '  \|    \  \     ||     ,_____/| /     /  \    \ |    |    |    ||    |  /     /\   / /\     |',
	\ '   |     \  |    ||     \-- \_|/|     |    |    ||    |    |    ||    | /     /\ \_/ / /    /|',
	\ '   |      \ |    ||     /___/|  |     |    |    ||    |    |    ||    ||     |  \|_|/ /    / |',
	\ '   |    |\ \|    ||     \____|\ |\     \  /    /||\    \  /    /||    ||     |       |    |  |',
	\ '   |____||\_____/||____       /|| \_____\/____/ || \ ___\/___ / ||____||\____\       |____|  /',
	\ '   |    |/ \|   |||    /_____/ | \ |    ||    | / \ |   ||   | / |    || |    |      |    | / ',
	\ '   |____|   |___|/|____|     | /  \|____||____|/   \|___||___|/  |____| \|____|      |____|/  ',
	\ '     \(       )/    \( |_____|/      \(    )/        \(    )/      \(      \(          )/     ',
	\ '                          \/                                                                  ',
\ ]

let g:startify_bookmarks = [
	\ '~/.bashrc',
	\ '~/.config/nvim/',
	\ '~/Documentos/Cpp-playground/mini-projects',
\ ]
