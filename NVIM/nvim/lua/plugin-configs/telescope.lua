local ok, telescope = pcall(require, 'telescope')
if not ok then
    return
end

telescope.setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {  width = 0.80, height = 0.95 },
    },
})
