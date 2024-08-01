local M = {}

M.setup = function()
  require("grug-far").setup({ windowCreationCommand = "tabnew %" })

  vim.cmd("hi! link GrugFarResultsMatch DiagnosticVirtualTextError")
end

return M
