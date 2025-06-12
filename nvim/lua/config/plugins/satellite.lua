---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("satellite").setup({
    current_only = false,
    excluded_filetypes = { "NvimTree" },
    width = 1,
    handlers = {
      gitsigns = {
        enable = false,
      },
      marks = {
        enable = false,
        show_builtins = false,
      },
    },
  })

  ---init
  if _G.show_scrollbar then
    vim.cmd(":SatelliteEnable")
  else
    vim.cmd(":SatelliteDisable")
  end

  vim.api.nvim_create_user_command("ToggleScrollbar", function()
    if _G.show_scrollbar then
      vim.cmd(":SatelliteDisable")
    else
      vim.cmd(":SatelliteEnable")
    end

    _G.show_scrollbar = not _G.show_scrollbar
  end, {})
end

return M
