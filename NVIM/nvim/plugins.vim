" Plugin management using vim-plug
call plug#begin()

" Cool status bar
Plug 'vim-airline/vim-airline'

" Quick commenting using 'gc' nd 'gcc'
Plug 'tpope/vim-commentary'

" A collection of color schemes
Plug 'rafi/awesome-vim-colorschemes'

" Syntax Highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Tree file with basic file managing
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'nvim-neo-tree/neo-tree.nvim'

" Language Servers Plugin
Plug 'neovim/nvim-lspconfig'

" We now have nvim-cmp completion plugin and extensions
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Now we have buffer tabs
Plug 'romgrk/barbar.nvim'

" New Start Screen
Plug 'mhinz/vim-startify'

call plug#end()
