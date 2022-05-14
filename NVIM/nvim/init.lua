-- Space as new Leader key
vim.g.mapleader = ' '

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

-- Key binding Settings
require('key-mappings')

-- Load Plugins
require('load-plugins')

-- Setup Plugins
require('setup-plugins.barbar')
require('setup-plugins.nvim-tree')
require('setup-plugins.lsp-config')
require('setup-plugins.treesitter')
require('setup-plugins.nvim-cmp')
require('setup-plugins.floaterm')
require('setup-plugins.telescope')
require('setup-plugins.startup-screen')

-- Setup color scheme
require('color-settings')

-- Fix window redimension
vim.cmd [[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]]
