---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("scrollbar").setup({})
end

return M
