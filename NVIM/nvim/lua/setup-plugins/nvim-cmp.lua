local ok, cmp = pcall(require, 'cmp')
if not ok then
    return
end

cmp.setup({

  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
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
		vsnip    = "[Snippet]",
		buffer   = "[Text]",
		path     = "[Path]",
	  })[entry.source.name]
	  return vim_item
	  end,
  },

  sources = {
    { name = 'nvim_lsp', max_item_count = 15 },
    { name = 'vsnip' },
	{ name = 'buffer', max_item_count = 10 },
	{ name = 'path', max_item_count = 20 },
    -- { name = 'vsnip', max_item_count = 10 },
  }, 

	window = {
		documentation = {
			border  = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			max_height = 24,
		    max_width = 106,
			winhighlight = "FloatBorder:NormalFloat",
		},
		
		completion = {
			border  = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		}
	}

})

-- Auto completions for  commands
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path', max_item_count = 20 }
  }, {
    { name = 'cmdline', max_item_count = 20 }
  })
})
