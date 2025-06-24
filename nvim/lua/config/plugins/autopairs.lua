local M = {}

M.setup = function()
  require("nvim-autopairs").setup({})

  if _G.enable_auto_pair then
    require("nvim-autopairs").enable()
  else
    require("nvim-autopairs").disable()
  end

  vim.api.nvim_create_user_command("ToggleAutoPairs", function()
    _G._G.enable_auto_pair = not _G._G.enable_auto_pair
    require("nvim-autopairs").toggle()
  end, {})
end

return M
