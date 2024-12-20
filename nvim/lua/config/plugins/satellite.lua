local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("satellite").setup({
    current_only = false,
    excluded_filetypes = { "NvimTree" },
    gitsigns = { enable = false, },
    marks = { enable = false, },
    width = 1,
  })
end

return M
