local M = {}

M.setup = function()
  require("flash").setup()

  vim.cmd("hi! link FlashLabel DiagnosticVirtualTextError")
  vim.cmd("hi! link FlashMatch DiagnosticVirtualTextWarn")
  vim.cmd("hi! link FlashCurrent DiagnosticVirtualTextInfo")
  -- vim.cmd("hi! link FlashPrompt ")
  -- vim.cmd("hi! link FlashBackdrop ")
  --
-- DiagnosticVirtualTextOk|1 col 1| DiagnosticVirtualTextOk
-- DiagnosticVirtualTextHint|1 col 1| DiagnosticVirtualTextHint
-- DiagnosticVirtualTextInfo|1 col 1| DiagnosticVirtualTextInfo
-- DiagnosticVirtualTextWarn|1 col 1| DiagnosticVirtualTextWarn
-- DiagnosticVirtualTextError|1 col 1| DiagnosticVirtualTextError
end

return M
