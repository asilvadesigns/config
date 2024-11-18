local M = {}

M.setup = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "minimal"

  -- -- local bg = "#fdf6e3" -- #0f3d38
  -- local bg = "#0f3d38" -- #fdf6e3

  local bg_mute = "#eee8d5"
  local bg_darker = "#93a1a1"
  -- local fg = '#002b36'

  -- -- local fg = "#073642" --#99e6dd
  -- local fg = "#99e6dd" --#073642

  local fg_lighter = "#acbcc2"

  local gray = "#67787b"
  -- local blue = "#268bd2"
  local blue = "#268bd2"
  local green = "#008078"
  local purple = "#55599e"
  local magenta = "#d33682"
  local violet = "#6c71c4"
  -- local yellow = "#7f6e3e"
  local yellow = "#b58900"
  local cyan = "#859900"
  local green_mute = "#b7e8ac"
  local red = "#d20f39"
  local red_mute = "#e8acac"
  local orange = "#df8e1d"

  local light = {
    fg = "#073642",
    fg_mute = "#d9d3c4",
    bg = "#fdf6e3",
  }

  local l02 = {
    fg = "#0E4D64",
    bg = "#D0F1E1",
  }

  local dark = {
    -- fg = "#1cba76",
    -- fg = "#99e6dd",
    fg = "#8ADCB4",

    -- bg = "#142e39",
    -- bg = "#0f3d38",
    bg = "#0E4D64",
    -- bg = "#086A59",
  }

  local c = light

  -- Prevent LSP from overwriting treesitter color settings
  -- https://github.com/NvChad/NvChad/issues/1907
  vim.highlight.priorities.semantic_tokens = 95

  -- cursor
  vim.api.nvim_set_hl(0, "Cursor", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "CursorLineFold", { bg = bg_mute })
  -- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#93a1a1" })
  -- vim.api.nvim_set_hl(0, "CursorLineSign", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "MatchParen", { bg = bg_darker })
  vim.api.nvim_set_hl(0, "Visual", { bg = bg_darker })
  -- vim.api.nvim_set_hl(0, "VisualNOS", { bg = red })

  -- normal
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "FloatShadow", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "FloatShadowThrough", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "Folded", { fg = blue, bg = c.bg })
  vim.api.nvim_set_hl(0, "Normal", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "Winbar", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "WinbarNC", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.fg_mute, bg = c.bg })

  -- popup
  vim.api.nvim_set_hl(0, "Pmenu", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "PmenuExtra", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "PmenuExtraSel", { bg = bg_darker })
  vim.api.nvim_set_hl(0, "PmenuKind", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "PmenuKindSel", { bg = bg_darker })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = bg_mute })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = bg_darker })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = bg_mute })

  -- syntax
  vim.api.nvim_set_hl(0, "@boolean", { fg = magenta })
  vim.api.nvim_set_hl(0, "@keyword", { fg = magenta })
  vim.api.nvim_set_hl(0, "@number", { fg = magenta })
  vim.api.nvim_set_hl(0, "@string", { fg = green })
  vim.api.nvim_set_hl(0, "@variable", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Constant", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Delimiter", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Directory", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Function", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Identifier", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Operator", { fg = c.fg })
  vim.api.nvim_set_hl(0, "PreProc", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Question", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Special", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Statement", { fg = c.fg })
  vim.api.nvim_set_hl(0, "String", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Title", { fg = c.fg })
  vim.api.nvim_set_hl(0, "Type", { fg = c.fg })

  -- syntax::comments
  vim.api.nvim_set_hl(0, "Comment", { fg = gray }) -- 9c9aa or "#849496"
  vim.api.nvim_set_hl(0, "Todo", { fg = gray }) -- these usually appear in a comment

  -- syntax::c
  vim.api.nvim_set_hl(0, "@boolean.c", { fg = magenta })
  vim.api.nvim_set_hl(0, "@function.c", { fg = blue })
  vim.api.nvim_set_hl(0, "@function.call.c", { fg = blue })
  vim.api.nvim_set_hl(0, "@keyword.conditional.c", { fg = magenta })
  vim.api.nvim_set_hl(0, "@constant.builtin.c", { fg = magenta })
  vim.api.nvim_set_hl(0, "@keyword.return.c", { bold = true })
  -- vim.api.nvim_set_hl(0, "@lsp.typemod.macro.globalScope.c", { fg = magenta })
  vim.api.nvim_set_hl(0, "@type.builtin.c", { fg = yellow })
  vim.api.nvim_set_hl(0, "@type.c", { fg = c.fg })

  -- syntax::cpp
  vim.api.nvim_set_hl(0, "@keyword.doxygen", { fg = c.fg })

  -- syntax::css
  vim.api.nvim_set_hl(0, "@number.float.css", { fg = magenta })
  vim.api.nvim_set_hl(0, "@string.css", { fg = c.fg })

  -- syntax::go
  vim.api.nvim_set_hl(0, "@type.builtin.go", { bold = true })

  -- syntax::markdown
  vim.api.nvim_set_hl(0, "@markup.heading", { bold = true })
  vim.api.nvim_set_hl(0, "@markup.list", { fg = magenta })

  -- syntax::make
  vim.api.nvim_set_hl(0, "@function.make", { bold = true })

  -- syntax::toml
  vim.api.nvim_set_hl(0, "@number.float.toml", { fg = magenta })

  -- syntax::tsx
  vim.api.nvim_set_hl(0, "@function.call.tsx", { fg = blue })
  -- vim.api.nvim_set_hl(0, "@function.tsx", { fg = blue })
  vim.api.nvim_set_hl(0, "@tag.tsx", { fg = blue })
  vim.api.nvim_set_hl(0, "@type.tsx", { fg = yellow })

  -- diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = red })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = green })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = blue })
  vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = green })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = orange })

  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = red, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = green, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = blue, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = green, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = orange, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = gray, sp = gray, undercurl = true }) -- could go lighter

  -- plugins
  vim.api.nvim_set_hl(0, "DevIconDefault", { fg = c.fg })
  vim.api.nvim_set_hl(0, "LazyNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "NoiceAttr1", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NoiceAttr19", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NoiceAttr9", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.fg })
  vim.api.nvim_set_hl(0, "OilFile", { fg = c.fg })
  vim.api.nvim_set_hl(0, "QuickFixLine", { fg = blue })
  vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = red })
  vim.api.nvim_set_hl(0, "TelescopePreviewMatch", { fg = red })
  vim.api.nvim_set_hl(0, "qfFileName", { fg = c.fg })

  -- plugins::lazy
  vim.api.nvim_set_hl(0, "LazyComment", { fg = c.fg, bold = true })

  -- plugins::fugitive
  vim.api.nvim_set_hl(0, "Added", { fg = green })
  vim.api.nvim_set_hl(0, "Removed", { fg = red })

  -- plugins::neogit
  vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = c.fg, bg = red_mute })
  vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = c.fg, bg = red_mute })

  vim.api.nvim_set_hl(0, "NeogitBranch", { fg = purple })
  vim.api.nvim_set_hl(0, "NeogitRemote", { fg = violet })
  vim.api.nvim_set_hl(0, "NeogitHunkHeader", { fg = c.fg })
  vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", { fg = blue })
  vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { fg = c.fg_mute })
  vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = red })
  vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = green })

  vim.api.nvim_set_hl(0, "NeogitDiffAdd", { fg = c.fg, bg = green_mute })
  vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = c.fg, bg = green_mute })
  -- vim.api.nvim_set_hl(0, "NeogitAddDelete", { fg = c.fg, bg = red_mute })
  -- vim.api.nvim_set_hl(0, "NeogitAddDeleteHighlight", { fg = c.fg, bg = red_mute })

  -- plugins::notify
  vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyLogIcon", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyLogTitle", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = c.fg, bold = true })

  --idk y TS acting weird...
  vim.api.nvim_set_hl(0, "typescriptParens", { link = "PreProc" })
end

M.setup()

return M
