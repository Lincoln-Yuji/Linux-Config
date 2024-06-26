-- VSCode Color Scheme

return {
  'Mofiqul/vscode.nvim',
  event = 'VimEnter',
  config = function()
    vim.cmd.colorscheme 'vscode'
    vim.api.nvim_set_hl(0, '@comment', { fg = '#5A5A5A' })
  end,
}
