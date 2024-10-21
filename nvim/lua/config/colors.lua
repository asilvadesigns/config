local M = {}

M.setup = function()
  -- Clear all highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Set the color scheme name
  vim.g.colors_name = "minimal"

  -- Set the background to light
  vim.o.background = "light"

  -- Define colors
  local colors = {
    white = "#ffffff",
    black = "#000000",
  }

  -- Set basic highlighting
  local highlight_groups = {
    Normal = { fg = colors.black, bg = colors.white },
    LineNr = { fg = colors.black },
    CursorLine = { bg = colors.white },
    Cursor = { fg = colors.white, bg = colors.black },
  }

  -- Apply highlights
  for group, settings in pairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
