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

set.wrap = false -- Don't break lines when the text is too large

set.pumheight = 10 -- Smaller pop-up window

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

-- Colors
vim.cmd [[ colorscheme nord ]] -- Set colorscheme

-- Important: the colorschemes can affect these options. Config based on 'nord' colorscheme
-- Better highlight for error messages
vim.cmd [[ autocmd VimEnter * :highlight! link Error SpellBad ]]
vim.cmd [[ autocmd VimEnter * :highlight! link ErrorMsg SpellBad ]]

-- Pop-Up menu highlight
vim.cmd [[ autocmd VimEnter * :highlight! link Pmenu NormalNC ]]
vim.cmd [[ autocmd VimEnter * :highlight! link PmenuSel Visual ]]
vim.cmd [[ autocmd VimEnter * :highlight! link PmenuSbar Visual ]]
vim.cmd [[ autocmd VimEnter * :highlight! link PmenuThumb Visual ]]

-- Git Add and Diff highlight
vim.cmd [[ autocmd VimEnter * :highlight! link DiffAdd GitGutterAdd ]]
vim.cmd [[ autocmd VimEnter * :highlight! link DiffDelete GitGutterDelete ]]

-- Fix window redimension
vim.cmd [[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]]
