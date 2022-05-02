-- local map = vim.api.nvim_set_keymap
-- local opt = { noremap = true }

-- map('n', '<Leader>t', ':FloatermToggle<CR>', opt)
vim.g.floaterm_keymap_toggle = '<F7>'

-- Float Window proportions
vim.g.floaterm_width = 0.85
vim.g.floaterm_height = 0.9

-- Vplit when open new window
vim.g.floaterm_opener = 'edit'

-- Black Border
vim.cmd [[ hi FloatermBorder guibg=black guifg=black ]]
