-- Use :TSInstall <lang> to install the support for a specific language.
-- Example -> :TSInstall cpp
--         -> :TSInstall lua
--         ...

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	}
}
