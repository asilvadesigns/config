local M = {}

M.setup = function()
  require("mason-lspconfig").setup({
    automatic_installation = true,
  })
end

return M
