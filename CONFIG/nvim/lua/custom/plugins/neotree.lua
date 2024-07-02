-- [[ Neotree configuration ]]

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- [[ Options ]]
    require('neo-tree').setup({
      window = {
        position = 'left',
        width = 35,
        mappings = {
          ['<tab>'] = 'toggle_node',
          ['<space>'] = 'none', -- Avoid conflict with our <leader> key
        },
      },
    })
    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>nn', '<cmd>Neotree toggle<CR>',
      { desc = 'Toggle [N]eotree' })
  end,
}
