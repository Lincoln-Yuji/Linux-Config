-- [[ Barbar Configuration ]]
-- Plugin to manage Vim Buffers more easily

return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local map_opts = { noremap = true, silent = true }

    -- Move to next and alternative keymaps as well
    vim.api.nvim_set_keymap('n', '<C-,>', '<cmd>BufferPrevious<CR>', map_opts)
    vim.keymap.set('n', '<leader>bp', '<cmd>BufferPrevious<CR>',
      { desc = '[B]uffer [P]revious (Ctrl+,)' })

    -- Move to previous buffer and alternative
    vim.api.nvim_set_keymap('n', '<C-.>', '<cmd>BufferNext<CR>', map_opts)
    vim.keymap.set('n', '<leader>bn', '<cmd>BufferNext<CR>',
      { desc = '[B]uffer [N]ext (Ctrl+.)' })

    -- Close buffer
    vim.api.nvim_set_keymap('n', '<leader>bc', '<cmd>BufferClose<CR>', map_opts)

    -- Fix weird barbar color groups
    vim.cmd [[ highlight! link BufferTabpageFill Normal ]]
    vim.cmd [[ highlight! link BufferInactiveSign Normal ]]
  end,
}
