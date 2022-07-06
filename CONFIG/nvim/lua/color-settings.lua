-- Colors
vim.cmd [[ colorscheme nord ]] -- Set colorscheme

-- Important: the colorschemes can affect these options. Config based on 'nord' colorscheme
-- Better highlight for error messages
vim.cmd [[ highlight! link Error SpellBad ]]
vim.cmd [[ highlight! link ErrorMsg SpellBad ]]

-- Pop-Up menu highlight
vim.cmd [[ highlight! link Pmenu NormalNC ]]
vim.cmd [[ highlight! link PmenuSel Visual ]]
vim.cmd [[ highlight! link PmenuSbar Visual ]]
vim.cmd [[ highlight! link PmenuThumb TermCursor ]]

-- Git Add and Diff highlight
vim.cmd [[ highlight! link DiffAdd GitGutterAdd ]]
vim.cmd [[ highlight! link DiffDelete GitGutterDelete ]]

-- FloatermBorder Black Border
vim.cmd [[ hi FloatermBorder guibg=black guifg=black ]]

-- Barbar setup
vim.cmd [[ highlight! link BufferCurrent Statement ]]
vim.cmd [[ highlight! link BufferInactive Comment ]]
vim.cmd [[ highlight! link BufferInactiveMod Comment ]]
vim.cmd [[ highlight! link BufferInactiveSign Comment ]]
vim.cmd [[ highlight! link BufferVisible Normal ]]
vim.cmd [[ highlight! link BufferVisibleSign Normal ]]
vim.cmd [[ highlight! link BufferTabpageFill Normal ]]

