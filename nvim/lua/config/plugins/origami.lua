--- @diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("origami").setup({
    autoFold = {
      enabled = false,
      kinds = { "comment", "imports" },
    },
  })
end

return M
