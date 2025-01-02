local M = {}

M.setup = function()
  require("spectre").setup({
    -- replace_engine = {
    --   ["sed"] = {
    --     cmd = "sed",
    --     args = {
    --       "-i",
    --       "",
    --       "-E",
    --     },
    --   },
    -- },
  })

  vim.cmd("hi! link SpectreSearch DiagnosticVirtualTextError")
  vim.cmd("hi! link SpectreReplace DiagnosticVirtualTextHint")
end

return M
