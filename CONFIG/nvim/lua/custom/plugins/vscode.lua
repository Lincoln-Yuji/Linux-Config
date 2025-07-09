-- VSCode Color Scheme

return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  config = function()
    -- Load colorscheme
    vim.cmd.colorscheme 'vscode'

    -- Default GREEN VSCode color for comments is too distracting!
    -- vim.api.nvim_set_hl(0, '@comment', { fg = '#5A5A5A' })

    -- When '@comment' is not used due to lack of a Treesitter for
    -- specific files, 'Comment' is the fallback, so it needs to be
    -- changed as well following the '@comment'
    -- vim.cmd [[ highlight! link Comment @comment ]]

    -- Prettier highlight for Additions and Deletions for Git
    vim.cmd [[ highlight! link DiffAdd GitGutterAdd ]]
    vim.cmd [[ highlight! link DiffDelete GitGutterDelete ]]
  end,
}
