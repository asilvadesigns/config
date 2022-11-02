local M = {}

M.setup = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })
end

return M
