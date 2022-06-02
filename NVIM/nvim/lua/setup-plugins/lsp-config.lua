local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end

-- Mappings.
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local map_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local map_buff = vim.api.nvim_buf_set_keymap
  map_buff(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map_buff(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map_buff(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map_buff(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

require("nvim-lsp-installer").setup {
    -- Ensure all the enabled language servers are installed
    ensure_installed = { "clangd", "rust_analyzer" },
    automatic_installation = true,
    -- Limit for the maximum amount of servers to be installed at the same time
    max_concurrent_installers = 6
}

-- lspconfig.sumneko_lua.setup {
--     on_attach = map_attach,
--     flags = { debounce_text_changes = 150 },
--     settings = {
--         Lua = {
--             diagnostics = {
--                 -- vim and use are global variables
--                 globals = { 'vim', 'use' }
--             }
--         }
--     }
-- }

lspconfig.rust_analyzer.setup {
    on_attach = map_attach,
    flags = { debounce_text_changes = 150 },
}

lspconfig.clangd.setup {
    on_attach = map_attach,
    flags = { debounce_text_changes = 150 },
    settings = {
        clangd = {
            arguments = {
              "-o",
              "bin/main",
              "-I",
              "/home/lincoln/.local/lib",
            },
        }
    }
}
