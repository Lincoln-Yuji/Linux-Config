local map = vim.api.nvim_set_keymap
local opt = { noremap = true }

map('n', '<Tab>', ':BufferNext<CR>', opt)
map('n', '<S-Tab>', ':BufferPrevious<CR>', opt)
map('n', '<Leader>bc', ':BufferClose<CR>', opt)

vim.g.bufferline = {
    -- icons = false,
    -- icon_close_tab = 'x',
    icon_separator_active = '|$',
}
