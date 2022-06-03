local ok, telescope = pcall(require, 'telescope')
if not ok then
    return
end

local telescope_actions = require("telescope.actions")

telescope.setup({
    defaults = {
        -- prompt_prefix = '   ',
        prompt_prefix = ' 🚀 ',
        layout_strategy = 'vertical',
        layout_config = {  width = 0.80, height = 0.95 },
    },
    -- Built-in pickers
    pickers = {
        find_files = {
            mappings = {
                ["i"] = {
                    ["<esc>"] = telescope_actions.close,
                    ["<C-j>"] = telescope_actions.move_selection_next,
                    ["<C-k>"] = telescope_actions.move_selection_previous,
                },
            },
        },
        oldfiles = {
            mappings = {
                ["i"] = {
                    ["<esc>"] = telescope_actions.close,
                    ["<C-j>"] = telescope_actions.move_selection_next,
                    ["<C-k>"] = telescope_actions.move_selection_previous,
                },
            },
        },
    },
    -- External pickers
    extensions = {
        file_browser = {
            mappings = {
                ["i"] = {
                    ["<esc>"] = telescope_actions.close,
                    ["<C-j>"] = telescope_actions.move_selection_next,
                    ["<C-k>"] = telescope_actions.move_selection_previous,
                },
            },
        },
    },
})

require("telescope").load_extension "file_browser"
