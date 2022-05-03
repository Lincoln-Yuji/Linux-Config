-- Key Mappings
local map = vim.api.nvim_set_keymap
local opt = { noremap = true }

-- Window navigation
map('n', '<Leader>wh', '<C-w>h', opt)
map('n', '<Leader>wj', '<C-w>j', opt)
map('n', '<Leader>wk', '<C-w>k', opt)
map('n', '<Leader>wl', '<C-w>l', opt)

-- Quick Split
map('n', '<Leader>wv', ':vs<CR>', opt)
map('n', '<Leader>ws', ':sp<CR>', opt)

-- Save file
map('n', '<Leader>fs', ':w<CR>', opt) 

-- Multitab
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

-- Keybindings Inside Floaterm
map('t', '<C-q>', 'exit<CR>', opt)
map('t', '<C-f>', 'a=$(fzf); if [ -z "$a" ]; then exit; else floaterm $a; exit; fi<CR>', opt)

-- F* keys
map('n', '<F7>', ':FloatermToggle<CR>', opt) -- Toggle Floaterm focused window
map('n', '<F8>', ':NvimTreeToggle<CR>', opt) -- Toggle NvimTree window
