-- Use :TSInstall <lang> to install the support for a specific language.
-- Example -> :TSInstall cpp
--         -> :TSInstall lua
--         ...
local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
    return
end

configs.setup {
    ensure_installed = {
        "cpp", "lua", "bash",
        "vim", "latex",
    },
	highlight = {
		enable = true,
	}
}
