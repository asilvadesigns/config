local M = {}

M.init = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "dark"

  local mine = {
    bg = "#21383d",
    -- bg = "#15272b",
    fg = "#127363",
  }

  local material = {
    bg = "#222937",
    fg = "#545c6c"
  }

  local c = mine

  -- cursor
  vim.api.nvim_set_hl(0, "CursorLine", { bg = c.bg })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = c.fg })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = c.fg })

  -- normal
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "FloatShadow", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "FloatShadowThrough", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "Folded", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "LineNr", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Normal", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = c.fg, fg = c.bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = c.fg, fg = c.bg })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "Winbar", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "WinbarNC", { fg = c.fg, bg = c.bg })

  -- syntax
  vim.api.nvim_set_hl(0, "Character", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Comment", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Constant", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Define", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Delimiter", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Directory", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Function", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Identifier", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Keyword", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Label", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Macro", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NonText", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Number", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Operator", { fg = c.fg })
  vim.api.nvim_set_hl(0, "PreProc", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Question", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Special", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Statement", { fg = c.fg })
  vim.api.nvim_set_hl(0, "String", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Structure", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Title", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Type", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Whitespace", { fg = c.fg })

  -- syntax
  vim.api.nvim_set_hl(0, "@variable", { fg = c.fg })
end

M.init()

return M
