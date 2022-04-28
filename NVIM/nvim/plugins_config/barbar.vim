let bufferline = get(g:, 'bufferline', {})

nnoremap <Space>bh :BufferPrevious<CR>
nnoremap <Space>bl :BufferNext<CR>
nnoremap <Space>bc :BufferClose<CR>

let bufferline.icons = v:false
let bufferline.icon_close_tab = 'x'
