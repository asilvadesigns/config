---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("trouble").setup({
    use_diagnostic_signs = true,
  })

  -- normal
  vim.cmd("hi! link TroubleNormal Normal")
  vim.cmd("hi! link TroubleNormalNC Normal")

  -- filename
  vim.cmd("hi! link TroubleFileName Normal")
  vim.cmd("hi! link TroubleFsFileName Normal")
  vim.cmd("hi! link TroubleQfFileName Normal")
  vim.cmd("hi! link TroubleFzfFileName Normal")
  vim.cmd("hi! link TroubleLspFileName Normal")
  vim.cmd("hi! link TroubleTelescopeFileName Normal")
  vim.cmd("hi! link TroubleDiagnosticsFileName Normal")

  -- directory
  vim.cmd("hi! link TroubleDirectory Normal")
end

return M
