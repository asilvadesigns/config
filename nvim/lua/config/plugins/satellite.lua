---@diagnostic disable: missing-fields
local M = {}

_G.scrollbar_enabled = false

M.setup = function()
  require("satellite").setup({
    current_only = true,
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
  if _G.scrollbar_enabled then
    vim.cmd(":SatelliteEnable")
  else
    vim.cmd(":SatelliteDisable")
  end

  vim.api.nvim_create_user_command("ToggleScrollbar", function()
    if _G.scrollbar_enabled then
      vim.cmd(":SatelliteDisable")
    else
      vim.cmd(":SatelliteEnable")
    end

    _G.scrollbar_enabled = not _G.scrollbar_enabled
  end, {})
end

return M
