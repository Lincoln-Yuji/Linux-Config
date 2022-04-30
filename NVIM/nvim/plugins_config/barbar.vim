let bufferline = get(g:, 'bufferline', {})

let bufferline.icons = v:false
let bufferline.icon_close_tab = 'x'
let bufferline.icon_separator_active = '▎$'

" Setting friendly Key Bindings
nmap <S-Tab> :BufferPrevious<CR>
nmap <Tab> :BufferNext<CR>
nmap <Leader>bc :BufferClose<CR>
