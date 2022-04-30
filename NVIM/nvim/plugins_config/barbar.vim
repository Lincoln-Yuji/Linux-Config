let bufferline = get(g:, 'bufferline', {})

let bufferline.icons = v:false
let bufferline.icon_close_tab = 'x'
let bufferline.icon_separator_active = '▎$'

" Setting friendly Key Bindings
map <Leader>bh :BufferPrevious<CR>
map <Leader>bl :BufferNext<CR>
map <Leader>bc :BufferClose<CR>
