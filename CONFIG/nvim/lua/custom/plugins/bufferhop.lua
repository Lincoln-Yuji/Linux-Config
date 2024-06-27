-- [[ Buffer Manager Configuration ]]

return {
  'j-morano/buffer_manager.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Keymaps
    local manager_ui = require('buffer_manager.ui')
    vim.keymap.set('n', '<C-b>', manager_ui.toggle_quick_menu)
    vim.keymap.set('n', '<C-n>', manager_ui.nav_next)
    vim.keymap.set('n', '<C-p>', manager_ui.nav_prev)
  end
}
