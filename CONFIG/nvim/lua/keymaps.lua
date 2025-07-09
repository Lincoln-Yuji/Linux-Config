-- [[ General keybindings ]]
-- This file contains generical keybindings indpendant from plugins

-- Erase sysntax-highlight after search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode by typing <Esc> two times
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<leader>wh', '<C-w><C-h>')
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>')
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>')
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>')

-- Better Visual tabbing
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
