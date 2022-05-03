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
vim.cmd [[ highlight! link PmenuThumb Visual ]]

-- Git Add and Diff highlight
vim.cmd [[ highlight! link DiffAdd GitGutterAdd ]]
vim.cmd [[ highlight! link DiffDelete GitGutterDelete ]]

-- FloatermBorder Black Border
vim.cmd [[ hi FloatermBorder guibg=black guifg=black ]]
