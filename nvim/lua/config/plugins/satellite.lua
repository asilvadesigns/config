---@diagnostic disable: missing-fields
local M = {}

_G.scrollbar_enabled = true

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
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
