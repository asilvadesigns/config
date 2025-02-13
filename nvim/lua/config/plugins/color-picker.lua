local M = {}

_G.toggle_enabled = true

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("oklch-color-picker").setup({
    highlight = {
      style = "virtual_left",
      enabled = _G.toggle_enabled,
    },
  })

  vim.api.nvim_create_user_command("ColorPickerToggle", function()
    if _G.toggle_enabled then
      require("oklch-color-picker").highlight.disable()
    else
      require("oklch-color-picker").highlight.enable()
    end
    _G.toggle_enabled = not _G.toggle_enabled
  end, {})
end

return M
