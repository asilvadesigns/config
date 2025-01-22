---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("satellite").setup({
    current_only = true,
    excluded_filetypes = { "NvimTree" },
    width = 1,
    handlers = {
      gitsigns = {
        enable = false,
      },
      marks = {
        enable = false,
        show_builtins = false,
      },
    },
  })
end

return M
