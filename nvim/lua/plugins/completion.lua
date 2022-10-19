local utils = require('core.utils')

local lspconfig = utils.get_plugin('lspconfig')

if (not lspconfig) then return end

local options = {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  flags = { debounce_text_changes = 150 },
  on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    -- vim.keymap.set('n', '<leader>m', vim.lsp.buf.format, bufopts)
    -- vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<leader>np', vim.diagnostic.goto_prev)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  end
}

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

-- @see: https://github.com/typescript-language-server/typescript-language-server
lspconfig['tsserver'].setup({
  capabilities = options.capabilities,
  flags = options.flags,
  on_attach = options.on_attach,
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
