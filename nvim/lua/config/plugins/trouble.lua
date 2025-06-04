---@diagnostic disable: missing-fields
local M = {}

_G.trouble_visible = false

M.setup = function()
  require("trouble").setup({
    use_diagnostic_signs = true,
  })

  vim.api.nvim_create_user_command("ToggleTrouble", function()
    _G.trouble_visible = not _G.trouble_visible
    require("trouble").toggle()
  end, {})

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
