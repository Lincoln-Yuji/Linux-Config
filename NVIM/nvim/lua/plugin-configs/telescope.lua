local ok, telescope = pcall(require, 'telescope')
if not ok then
    return
end

telescope.setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {  width = 0.80, height = 0.95 },
    },
    extensions = {
        file_browser = {
            mappings = {
                ["n"] = {
                    f = false
                },
            },
        },
    },
})

require("telescope").load_extension "file_browser"
