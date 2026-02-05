local M = {}

M.setup = function()
  --- TODO: will need to update to handle color changes...
  local colors = require("catppuccin.palettes").get_palette("frappe")

  require("modes").setup({
    colors = {
      copy = colors.yellow,  --- "#e5c890",
      delete = colors.red,   ---"#e78284",
      insert = colors.teal,  ---"#78ccc5",
      visual = colors.muave, --- "#8caaee",
    },
    ignore = {
      "NvimTree",
      "TelescopePrompt",
    },
    set_cursorline = false,
  })
end

return M
