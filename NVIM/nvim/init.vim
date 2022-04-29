" My init.vim configs

" Load all plugins
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugins_config/lang_servers.vim
source ~/.config/nvim/plugins_config/nvim_tree.vim
source ~/.config/nvim/plugins_config/nvim_cmp.vim
source ~/.config/nvim/plugins_config/barbar.vim
source ~/.config/nvim/plugins_config/treesitter.vim
source ~/.config/nvim/plugins_config/startify.vim

" Relative number bar indicator
:set number
:set relativenumber

" Indentation config
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4

" We can use mouse too
:set mouse=nicr
:set mouse=a

" 'Fixing' vim split priority
:set splitright
:set splitbelow

:colorscheme nord " Personal default color scheme

" Navigation through splits similar to DOOM Emacs 
nnoremap <Space>wh <C-w>h
nnoremap <Space>wj <C-w>j
nnoremap <Space>wk <C-w>k
nnoremap <Space>wl <C-w>l

" Surrounding selected text [Note: this overwrites the yank buffer]
map <Space>) di()<ESC>P
map <Space>] di[]<ESC>P
map <Space>" di""<ESC>P

" Post from stack overflow:
" https://stackoverflow.com/questions/6821033/vim-how-to-run-a-command-immediately-when-starting-vim
" ================================================================================================== "
" At startup, Vim checks environment variables and files and sets values
" accordingly.  Vim proceeds in this order:

" 1. Set the 'shell' and 'term' option                *SHELL* *COMSPEC* *TERM*
" 2. Process the arguments
" 3. Execute Ex commands, from environment variables and/or files *vimrc* *exrc* *init.vim*
" 4. Load the plugin scripts.                                 *load-plugins*
" 5. Set 'shellpipe' and 'shellredir'
" 6. Set 'updatecount' to zero, if "-n" command argument used
" 7. Set binary options
" 8. Perform GUI initializations
" 9. Read the viminfo file
" 10. Read the quickfix file
" 11. Open all windows
" 12. Execute startup commands
" ================================================================================================== "
" autocmd VimEnter * TSEnable highlight " Enable the treesitter highlight on neovim startup
" Use :TSInstall <lang> to install the support for a specific language.
" Example -> :TSInstall cpp
