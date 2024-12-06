local M = {}

M.setup = function()
  require("better_escape").setup({
    default_mappings = false,
    mappings = {
      i = {
        k = { j = "<Esc>" },
      },
    },
  })
end

return M
