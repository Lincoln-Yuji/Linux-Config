-- [[ Lualine Configuration ]]

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    -- For some reason passing `options` doesn't work with this plugin
    -- via Lazy. We need to call `require` after the plugin is loaded and
    -- then pass the options.
    require('lualine').setup({
      theme = 'vscode',
      options = {
        icons_enabled = vim.g.have_nerd_font,
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    })
  end,
}
