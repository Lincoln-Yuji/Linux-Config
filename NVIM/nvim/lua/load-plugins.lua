-- Loading plugins using the Packer package manager
require('packer').startup( function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'kyazdani42/nvim-web-devicons'    -- Icon Package

    use 'vim-airline/vim-airline'         -- Bottom status bar
    use 'tpope/vim-commentary'            -- Quickly commenting lines
    use 'rafi/awesome-vim-colorschemes'   -- Set of color schemes

    use 'romgrk/barbar.nvim'          -- Friendly Tabs
    use 'kyazdani42/nvim-tree.lua'    -- File Tree

    use 'neovim/nvim-lspconfig'            -- Language Server Config
    use 'williamboman/nvim-lsp-installer'  -- Installer extension for LSP

    use {
        'nvim-treesitter/nvim-treesitter', -- Advanced Syntax Highlight
        run = ':TSUpdate',
    }

    use {
        'nvim-telescope/telescope.nvim',   -- Telescope Plugin (Fuzzy Finder)
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'startup-nvim/startup.nvim'        -- Start Screen (requires telescope)
    use 'nvim-telescope/telescope-file-browser.nvim' -- Telescope extension

    -- Snippets
    use 'hrsh7th/cmp-nvim-lsp'     -- Integration with LSP
    use 'hrsh7th/cmp-buffer'       -- Completion for words on file
    use 'hrsh7th/cmp-path'         -- Completion for system paths
    use 'hrsh7th/cmp-cmdline'      -- Completion for commands
    use 'hrsh7th/nvim-cmp'         -- Completion plugin

    use 'hrsh7th/cmp-vsnip' -- Snippet Engine
    use 'hrsh7th/vim-vsnip' -- Enable vim snippets

    use 'rafamadriz/friendly-snippets' -- Snippet collection

    use 'voldikss/vim-floaterm'    -- Floating terminal window

    use 'windwp/nvim-autopairs'  -- Auto pairs
end )
