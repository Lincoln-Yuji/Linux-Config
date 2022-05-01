-- Space as new Leader key
vim.g.mapleader = ' '

-- Load plugins
require('load-plugins')

-- Config plugins
require('plugin-configs/barbar')
require('plugin-configs/nvim-tree')
require('plugin-configs/startify')
require('plugin-configs/lang-servers')
require('plugin-configs/treesitter')
require('plugin-configs/nvim-cmp')
require('plugin-configs/floaterm')

-- Global Settings:
local set = vim.opt

set.number = true          -- Line numbers
set.relativenumber = true  -- Relative to cursor

set.autoindent = true  -- Auto indentation
set.tabstop = 4        
set.shiftwidth = 4     -- Tab len = 4 spaces
set.smarttab = true    -- Breakline tab
set.softtabstop = 4    
set.expandtab = true   -- Tab = 4 spaces

set.mouse = 'a' -- We can now use mouse inside vim

set.splitright = true
set.splitbelow = true

set.wrap = false

set.pumheight = 10 -- Smaller pop-up window

vim.cmd [[colorscheme nord]] -- Set colorscheme

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

vim.cmd [[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]]

-- Error hightlight = SpellBad highlight
vim.cmd [[ autocmd VimEnter * :highlight! link Error SpellBad ]]
-- Pop-Up menu highlight
vim.cmd [[ autocmd VimEnter * :highlight! link Pmenu NormalNC ]]
