local M = {}

M.setup = function()
  require("modes").setup({
    colors = {
      copy = "#e5c890",
      delete = "#e78284",
      insert = "#78ccc5",
      visual = "#8caaee",
    },
    ignore_filetypes = {
      "NvimTree",
      "TelescopePrompt",
    },
    set_cursorline = false,
  })
end

return M
