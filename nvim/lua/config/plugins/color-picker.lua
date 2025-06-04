local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("oklch-color-picker").setup({
    highlight = {
      style = "virtual_left",
      enabled = _G.color_picker_enabled,
    },
  })

  vim.api.nvim_create_user_command("ColorPickerToggle", function()
    if _G.color_picker_enabled then
      require("oklch-color-picker").highlight.disable()
    else
      require("oklch-color-picker").highlight.enable()
    end
    _G.color_picker_enabled = not _G.color_picker_enabled
  end, {})
end

return M
