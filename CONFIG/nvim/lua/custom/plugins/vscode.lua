-- VSCode Color Scheme

return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  config = function()
    -- Load colorscheme
    vim.cmd.colorscheme 'vscode'

    -- Default GREEN VSCode color for comments is too distracting!
    vim.api.nvim_set_hl(0, '@comment', { fg = '#5A5A5A' })

    -- Prettier highlight for Additions and Deletions for Git
    vim.cmd [[ highlight! link DiffAdd GitGutterAdd ]]
    vim.cmd [[ highlight! link DiffDelete GitGutterDelete ]]
  end,
}
