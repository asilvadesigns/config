local M = {}

M.setup = function()
  local cmp = require('cmp')

  require('mason').setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗'
      }
    }
  })

  require('mason-lspconfig').setup({
    automatic_installation = true,
    ensure_installed = {
      'cssls',
      'eslint',
      'html',
      'jsonls',
      'pyright',
      'sumneko_lua',
      'tsserver',
      'yamlls'
    },
  })

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
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
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
    }),
    formatting = {
      format = require('lspkind').cmp_format({
        mode = 'symbol',
        maxwidth = 50,
      })
    }
  })

  -- NOTE: Hide ugly inline diagnostic info
  -- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
  vim.diagnostic.config({
    virtual_text = false
  })

  -- NOTE: Diagnostics in gutter
  -- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
  local signs = {
    Error = '',
    Hint = '',
    Info = '',
    Warn = '',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- NOTE: see all servers!
  -- @see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<leader>np', vim.diagnostic.goto_prev)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>m', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  end

  -- NOTE: see all servers!
  -- @see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  require('lspconfig')['sumneko_lua'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          }
        },
      }
    }
  })

  require('lspconfig')['tsserver'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')['cssls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')['eslint'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')['html'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')['jsonls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')['pyright'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')['yamlls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
