local M = {}

M.setup = function()
  require("mason").setup({
    ui = {
      border = "rounded",
      backdrop = 100,
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "biome",
      "clangd",
      "cssls",
      "tailwindcss",
      "superhtml",
      "jsonls",
      "glsl_analyzer",
      "gopls",
      "templ",
      "lua_ls",
      "rust_analyzer",
      "vtsls",
      "postgres_lsp",
      "basedpyright",
      "yamlls",
      "sourcekit",
      "zls",
    },
  })
end

return M
