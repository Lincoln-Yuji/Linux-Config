" My init.vim configs

" Space is now our Leader key (Must be set before plugins)
let g:mapleader = ' '

" Load all plugins
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugins_config/lang_servers.vim
source ~/.config/nvim/plugins_config/nvim_tree.vim
source ~/.config/nvim/plugins_config/nvim_cmp.vim
source ~/.config/nvim/plugins_config/barbar.vim
source ~/.config/nvim/plugins_config/treesitter.vim
source ~/.config/nvim/plugins_config/startify.vim

" Relative number bar indicator
set number
set relativenumber

" Indentation config
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4

" We can use mouse too
set mouse=nicr
set mouse=a

" 'Fixing' vim split priority
set splitright
set splitbelow

colorscheme nord " Personal default color scheme

" ================================ "
"  DEFAULT VIM REMAPPINGS MAPINGS
" ================================ "

" Easier navigation through windows
map <Leader>wh <C-w>h
map <Leader>wj <C-w>j
map <Leader>wk <C-w>k
map <Leader>wl <C-w>l

" Quick vertical split
map <Leader>wv :vs<CR>
map <Leader>ws :sp<CR>

" Write (save) file modifications
map <Leader>fs :w<CR>

" Writing and closing
map <Leader>wc :wq<CR>
map <Leader>zz :wqall<CR>

" Alacritty doesn't resize properly when the window changes its dimension.
" That fixes it!
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

