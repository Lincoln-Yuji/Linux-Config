-- Space as new Leader key
vim.g.mapleader = ' '

-- Main Settings
require('color-settings')
require('key-mappings')

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

-- Load plugins
require('load-plugins')

-- Config plugins
require('plugin-configs.barbar')
require('plugin-configs.nvim-tree')
require('plugin-configs.lang-servers')
require('plugin-configs.treesitter')
require('plugin-configs.nvim-cmp')
require('plugin-configs.floaterm')
require('plugin-configs.telescope')
require('plugin-configs.startup-screen')

-- Fix window redimension
vim.cmd [[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]]
