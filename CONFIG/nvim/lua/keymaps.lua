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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

