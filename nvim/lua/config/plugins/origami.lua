--- @diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("origami").setup({
    autoFold = {
      enabled = false,
    },
    foldKeymaps = {
      setup = false, -- modifies `h`, `l`, and `$`
    },
  })
end

return M
