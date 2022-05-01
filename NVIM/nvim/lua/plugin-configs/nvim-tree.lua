vim.api.nvim_set_keymap('n', '<F8>', ':NvimTreeToggle<CR>', {noremap = true})

require'nvim-tree'.setup {
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
