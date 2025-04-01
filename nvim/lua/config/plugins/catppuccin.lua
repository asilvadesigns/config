local M = {}

M.setup = function()
  local is_dark = false
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      bufferline = false,
      fzf = false,
      grug_far = true,
      illuminate = false,
      leap = false,
      notify = false,
      nvimtree = false,
      treesitter = true,
      treesitter_context = false,
      ufo = false,
    },
    color_overrides = {
      latte = require("config.colors").light.vscode,
      frappe = require("config.colors").dark.vscode,
    },
    highlight_overrides = {
      all = function(c)
        local statusline_bg = c.surface0
        local statusline_fg = c.overlay1

        local bg = ""
        if is_dark then
          bg = utils.darken(c.surface0, 0.40, c.base)
        else
          bg = utils.darken(c.surface0, 0.60, c.base)
        end

        return {
          -- ["@constructor.lua"] = { fg = c.subtext0 },
          -- ["@punctuation.bracket"] = { fg = c.subtext0 },
          -- -- ["@lsp.type.parameter.typescriptreact"] = { fg = c.subtext1 },
          -- -- ["@tag.builtin.tsx"] = { fg = c.mauve },
          -- -- -- ["@variable"] = { fg = c.teal },
          -- ["@variable.builtin"] = { fg = c.text },
          -- ["@variable.parameter"] = { fg = c.text },

          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.teal }, -- , fg = c.mauve }, -- or c.overlay2
          CursorLineSign = { bg = bg },
          DiagnosticUnderlineError = { sp = c.red, undercurl = true },
          DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
          DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          FloatBorder = { bg = c.base, fg = c.overlay0 },
          Folded = { bg = c.base },
          -- GrugFarResultsPath = { fg = c.text, bg = c.mantle, underline = true },
          MasonNormal = { bg = c.base },
          MatchParen = {
            bg = utils.darken(c.yellow, 0.2, c.base),
            fg = c.yellow,
            style = {},
          },
          NormalFloat = { bg = c.base },
          NvimTreeCursorLine = { fg = c.blue, bg = bg }, -- or c.base
          NvimTreeCursorLineNr = { fg = c.blue, bg = bg }, -- or c.base
          NvimTreeExecFile = { fg = c.overlay1 },
          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeIndentMarker = { fg = c.surface0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeRootFolder = { fg = c.overlay1 },
          NvimTreeSpecialFile = { fg = c.overlay1 },
          QuickFixLine = { bg = c.mantle },
          SnacksIndent = { fg = c.surface0 },
          SnacksIndentScope = { fg = c.surface2 },
          SnacksPickerMatch = { fg = c.red },
          StatusLine = { fg = c.surface0, bg = c.base },
          StatusLineNC = { fg = c.surface0, bg = c.base },
          -- StatusLine = { fg = statusline_fg, bg = statusline_bg },
          -- StatusLineNC = { fg = statusline_fg, bg = statusline_bg },
          TabLine = { bg = c.mantle },
          TreesitterContextBottom = { fg = c.overlay0, underline = false },
          TreesitterContextLineNumberBottom = { fg = c.overlay0, underline = false },
          Visual = { bg = c.surface1, style = {} },
          WVisiMatch = { bg = c.surface0 },
          WinBar = { fg = c.overlay1 },
          WinBarNC = { fg = c.surface2 },
          WinSeparator = { fg = c.surface0 }, -- or c.base
        }
      end,
    },
  })

  -- # dark
  if is_dark then
    vim.cmd("colorscheme catppuccin-frappe")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end

  vim.cmd("hi! link FoldColumn LineNr")
end

return M
