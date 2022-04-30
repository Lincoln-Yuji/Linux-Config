" Use :TSInstall <lang> to install the support for a specific language.
" Example -> :TSInstall cpp

lua << EOF

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	}
}

EOF
