local M = {}

M.setup = function()
  require("spectre").setup({})

  vim.cmd("hi! link SpectreSearch DiagnosticVirtualTextError")
  vim.cmd("hi! link SpectreReplace DiagnosticVirtualTextHint")
end

return M
