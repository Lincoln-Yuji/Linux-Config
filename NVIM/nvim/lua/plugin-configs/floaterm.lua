-- local map = vim.api.nvim_set_keymap
-- local opt = { noremap = true }

-- map('n', '<Leader>t', ':FloatermToggle<CR>', opt)
vim.g.floaterm_keymap_toggle = '<F7>'

vim.cmd [[ autocmd VimEnter * hi FloatermBorder guibg=black guifg=black<CR>]]
