-- [[ Toggleterm config ]]
-- Offers an easier way to use TERMINAL mode in Neovim

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    -- [[ Options ]]
    require('toggleterm').setup({
      shell = '/bin/zsh',
      size = 25,
    })

    -- [[ Keymaps ]]
    local map_opts = { noremap = true, silent = true }

    -- Default keybind to toggle the terminal window
    vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>ToggleTerm<CR>', map_opts)
    vim.api.nvim_set_keymap('t', '<C-t>', '<cmd>ToggleTerm<CR>', map_opts)
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = '[T]oggle [T]erminal (Ctrl+t)' })
  end,
}
