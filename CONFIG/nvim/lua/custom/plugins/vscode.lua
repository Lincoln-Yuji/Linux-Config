-- VSCode Color Scheme

return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'vscode'
    vim.api.nvim_set_hl(0, '@comment', { fg = '#5A5A5A' })
  end,
}
