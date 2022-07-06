local map = vim.api.nvim_set_keymap
local opt = { noremap = true }

map('n', '<Tab>',      '<cmd>BufferNext<CR>',     opt)
map('n', '<S-Tab>',    '<cmd>BufferPrevious<CR>', opt)
map('n', '<Leader>bc', '<cmd>BufferClose<CR>',    opt)
