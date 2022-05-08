local ok, configs = pcall(require, 'nvim-tree')
if not ok then
    return
end

configs.setup {
    view = {
        width=33,
    },
    renderer = {
        indent_markers = {
            enable = true,
        }
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
}
