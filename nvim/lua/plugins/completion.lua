local utils = require('core.utils')

local cmp = utils.get_plugin('cmp')
if (not cmp) then return end

local cmplsp = utils.get_plugin('cmp_nvim_lsp')
if (not cmplsp) then return end

local lspconfig = utils.get_plugin('lspconfig')
if (not lspconfig) then return end

local lspkind = utils.get_plugin('lspkind')
if (not lspkind) then return end

local luasnip = utils.get_plugin('luasnip')
if (not luasnip) then return end

-- NOTE: setup completion
-- @see: https://github.com/hrsh7th/nvim-cmp#setup
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
})

-- NOTE: Hide ugly inline diagnostic info
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
vim.diagnostic.config({
  virtual_text = false
})

-- NOTE: Diagnostics in gutter
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = {
  Error = " ",
  Hint = " ",
  Info = " ",
  Warn = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- NOTE: see all servers!
-- @see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local options = {
  capabilities = cmplsp.default_capabilities(),
  flags = { debounce_text_changes = 150 },
  on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<leader>np', vim.diagnostic.goto_prev)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>m', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  end
}

-- NOTE: Server for JSON
-- @see: https://github.com/hrsh7th/vscode-langservers-extracted
lspconfig['jsonls'].setup({
  capabilities = options.capabilities,
  flags = options.flags,
  on_attach = options.on_attach,
})

-- NOTE: Server for Lua
-- @see: https://github.com/sumneko/lua-language-server
lspconfig['sumneko_lua'].setup({
  capabilities = options.capabilities,
  flags = options.flags,
  on_attach = options.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      }
    }
  }
})

-- NOTE: Server for TypeScript
-- @see: https://github.com/typescript-language-server/typescript-language-server
lspconfig['tsserver'].setup({
  capabilities = options.capabilities,
  flags = options.flags,
  on_attach = options.on_attach,
})
