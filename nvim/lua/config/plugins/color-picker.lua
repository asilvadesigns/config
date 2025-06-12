local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("oklch-color-picker").setup({
    highlight = {
      style = "virtual_left",
      enabled = _G.enable_color_picker,
    },
  })

  vim.api.nvim_create_user_command("ColorPickerToggle", function()
    if _G.enable_color_picker then
      require("oklch-color-picker").highlight.disable()
    else
      require("oklch-color-picker").highlight.enable()
    end
    _G.enable_color_picker = not _G.enable_color_picker
  end, {})
end

return M
