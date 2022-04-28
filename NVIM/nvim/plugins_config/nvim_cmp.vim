lua << EOF

local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
	['<Tab>'] = function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
	end,
	['<S-Tab>'] = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		else
			fallback()
		end
	end
  }),

  formatting = {
	  fields = {"abbr", "menu"},
	  format = function(entry, vim_item)
	  vim_item.menu = ({
	    nvim_lsp = "[LSP]",
		vsnip = "[Snippet]",
		buffer = "[Text]",
		path = "[Path]",
	  })[entry.source.name]
	  return vim_item
	  end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
	{ name = 'buffer'},
	{ name = 'path'},
  }, 
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig -> connect cmp_nvim with the lsp plugin
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- In this case e are connected to the clangd sever.
--require('lspconfig')['clangd'].setup {
--  capabilities = capabilities
--}

EOF
