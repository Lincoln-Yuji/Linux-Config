" Mappings
nnoremap <F8> :NvimTreeToggle<CR>

" Tree Icons
let g:nvim_tree_icons = {
    \ 'default': " ",
    \ 'symlink': "x",
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "$",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "x",
    \   'ignored': "x"
    \   },
    \ 'folder': {
    \   'arrow_open': "-",
    \   'arrow_closed': "+",
    \   'default': "+",
    \   'open': "-",
    \   'empty': "+",
    \   'empty_open': "-",
    \   'symlink': "*",
    \   'symlink_open': "*",
    \   }
    \ }

lua << EOF

-- Using default configuration
require'nvim-tree'.setup {
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
}

EOF
