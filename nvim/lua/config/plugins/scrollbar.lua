---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("scrollbar").setup({
    show = _G.show_scrollbar,
    excluded_filetypes = {
      "DressingInput",
      "NvimTree",
      "TelescopePrompt",
      "cmp_docs",
      "cmp_menu",
      "dropbar_menu",
      "dropbar_menu_fzf",
      "noice",
      "prompt",
    },
  })

  ---init
  vim.api.nvim_create_user_command("ToggleScrollbar", function()
    local config = require("scrollbar.config").get()

    if _G.show_scrollbar then
      config.show = false
    else
      config.show = true
    end

    _G.show_scrollbar = not _G.show_scrollbar
    require("scrollbar").render()
  end, {})
end

return M
