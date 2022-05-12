local ok, telescope = pcall(require, 'telescope')
if not ok then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = '🚀 ',
        layout_strategy = 'vertical',
        layout_config = {  width = 0.80, height = 0.95 },
    },
    pickers = {
        file_browser = {
            find_command = {"rg", "--ignore", "-L", "--hidden", "--files"},
        }
    },
    extensions = {
        file_browser = {
            mappings = {
                ["i"] = {
                    ["<esc>"] = require("telescope.actions").close,
                },
                ["n"] = {
                    f = false
                },
            },
        },
    },
})

require("telescope").load_extension "file_browser"
