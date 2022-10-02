local m_ok, mason = pcall(require, 'mason')
if (not m_ok) then return end

local l_ok, mason_lsp = pcall(require, 'mason-lspconfig')
if (not l_ok) then return end

local n_ok, nvim_lsp = pcall(require, 'lspconfig')
if (not n_ok) then return end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lsp.setup({
  automatic_installation = true,
  ensure_installed = {
    'angularls',
    'emmet_ls',
    'eslint',
    'html',
    'jsonls',
    'sumneko_lua',
    'tsserver',
    'yamlls',
  },
})

local servers = {
  sumneko_lua = {
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
  }
}

mason_lsp.setup_handlers({
  function (server_name)
    if (servers[server_name]) then
      nvim_lsp[server_name].setup(servers[server_name])
    else
      nvim_lsp[server_name].setup({})
    end
  end
})
