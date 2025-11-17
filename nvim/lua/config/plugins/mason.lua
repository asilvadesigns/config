local M = {}

M.setup = function()
  require("mason").setup({
    ui = {
      border = "rounded",
      backdrop = 100,
    },
  })
end

return M
