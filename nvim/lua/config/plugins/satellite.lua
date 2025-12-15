---@diagnostic disable: missing-fields
local M = {}

local toggle = function()
  if _G.show_scrollbar then
    vim.cmd(":SatelliteEnable")
  else
    vim.cmd(":SatelliteDisable")
  end
end

M.setup = function()
  require("satellite").setup({
    current_only = false,
    excluded_filetypes = {
      "NvimTree",
    },
    width = 1,
    handlers = {
      cursor = {
        enable = false,
      },
      gitsigns = {
        enable = false,
      },
      marks = {
        enable = false,
        show_builtins = false,
      },
    },
  })

  toggle()
  vim.api.nvim_create_user_command("ToggleScrollbar", function()
    _G.show_scrollbar = not _G.show_scrollbar
    toggle()
  end, {})
end

return M
