local M = {}

local toggle = function()
  if _G.show_vimade then
    vim.cmd("VimadeEnable")
  else
    vim.cmd("VimadeDisable")
  end
end

M.setup = function()
  require("vimade").setup({
    recipe = {
      "default",
      { animate = false, },
    },
    fadelevel = 0.8,
  })

  toggle()
  vim.api.nvim_create_user_command("ToggleVimade", function()
    _G.show_vimade = not _G.show_vimade
    toggle()
  end, {})
end

return M
