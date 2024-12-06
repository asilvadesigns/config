local M = {}

M.setup = function()
  require("smear_cursor").setup({
    cursor_color = "#e78284",
    stiffness = 0.6,
    trailing_stiffnewss = 0.1,
    trailing_exponent = 5,
    gamma = 1,
  })
end

return M
