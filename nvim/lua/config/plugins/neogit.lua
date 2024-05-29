local M = {}

M.setup = function()
  require("neogit").setup({
    signs = {
      hunk = { "", "" },
      item = { "", "" },
      section = { "", "" },
    },
  })
end

return M
