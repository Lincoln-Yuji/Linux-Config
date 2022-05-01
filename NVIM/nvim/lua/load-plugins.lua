-- Loading plugins using the Packer package manager
require('packer').startup( function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'vim-airline/vim-airline'         -- Bottom status bar
    use 'tpope/vim-commentary'            -- Quickly commenting lines
    use 'rafi/awesome-vim-colorschemes'   -- Set of color schemes

    use 'romgrk/barbar.nvim'              -- Friendly Tabs
    use 'kyazdani42/nvim-tree.lua'        -- File Tree
    use 'mhinz/vim-startify'              -- Start Screen

    use 'neovim/nvim-lspconfig'           -- Language Server Config
    use 'nvim-treesitter/nvim-treesitter' -- Advanced Syntax Highlight

    -- Auto completion
    use 'hrsh7th/nvim-cmp'                -- Completion plugin
    use 'hrsh7th/cmp-nvim-lsp'            -- Integration with LSP
    use 'hrsh7th/cmp-buffer'              -- Completion for words on file
    use 'hrsh7th/cmp-path'                -- Completion for system paths
    use 'hrsh7th/cmp-cmdline'             -- Completion for commands
    use 'hrsh7th/cmp-vsnip'               -- Completion snippets
    use 'hrsh7th/vim-vsnip'               -- Completion for vim

end )
