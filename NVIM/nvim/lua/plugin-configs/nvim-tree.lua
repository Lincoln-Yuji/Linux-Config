require'nvim-tree'.setup {
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
