local M = {}

M.setup = function()
  local is_dark = false
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      bufferline = false,
      diffview = true,
      fzf = false,
      grug_far = true,
      illuminate = false,
      leap = false,
      notify = false,
      nvimtree = false,
      neogit = true,
      treesitter = true,
      treesitter_context = false,
      ufo = false,
    },
    color_overrides = {
      latte = require("config.colors").light.dead,
      frappe = require("config.colors").dark.dead,
    },
    highlight_overrides = {
      all = function(c)
        local statusline_bg = c.surface0
        local statusline_fg = c.overlay1

        local bg = ""
        if is_dark then
          bg = utils.darken(c.surface0, 0.40, c.base)
        else
          bg = utils.darken(c.yellow, 0.10, c.base)
          -- bg = utils.darken(c.surface0, 0.20, c.base)
        end

        return {
          ["@constructor.lua"] = { fg = c.subtext0 },
          ["@lsp.type.parameter.typescript"] = { fg = c.text },
          ["@lsp.type.property.lua"] = { fg = c.text },
          ["@lsp.typemod.interface.defaultLibrary.typescript"] = { fg = c.yellow },
          ["@lsp.typemod.method.defaultLibrary.typescript"] = { fg = c.text },
          ["@lsp.typemod.property.declaration.typescript"] = { fg = c.text },
          ["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = c.text },
          ["@lsp.typemod.variable.readonly.typescript"] = { fg = c.text },
          ["@property.json"] = { fg = c.text },
          ["@punctuation.bracket"] = { fg = c.subtext0 },
          ["@punctuation.special.typescript"] = { fg = c.subtext0 },
          -- -- ["@lsp.type.parameter.typescriptreact"] = { fg = c.subtext1 },
          -- -- ["@tag.builtin.tsx"] = { fg = c.mauve },
          -- -- -- ["@variable"] = { fg = c.teal },
          -- ["@variable.builtin"] = { fg = c.text },
          -- ["@variable.parameter"] = { fg = c.text },

          CursorLine = { bg = utils.darken(c.yellow, 0.10, c.base) },
          CursorLineFold = { bg = bg, fg = c.overlay2 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.teal }, -- , fg = c.mauve }, -- or c.overlay2
          CursorLineSign = { bg = bg },
          DiagnosticUnderlineError = { sp = c.red, undercurl = true },
          DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
          DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          FloatBorder = { bg = c.base, fg = c.overlay0 },
          Folded = { bg = c.base },
          FoldColumn = { fg = c.red },
          SignColumn = { fg = c.red },
          MasonNormal = { bg = c.base },
          MasonBackdrop = { bg = "#0000FF" },
          MatchParen = {
            bg = utils.darken(c.yellow, 0.2, c.base),
            fg = c.yellow,
            style = {},
          },
          NormalFloat = { bg = c.base },

          NvimTreeCursorLine = { fg = c.blue, bg = bg }, -- or c.base
          NvimTreeCursorLineNr = { fg = c.blue, bg = bg }, -- or c.base
          --- lightest
          NvimTreeIndentMarker = { fg = c.surface1 },
          --- lighter
          NvimTreeExecFile = { fg = c.overlay2 },
          NvimTreeNormal = { fg = c.overlay2, bg = c.base },
          NvimTreeRootFolder = { fg = c.overlay2 },
          NvimTreeSpecialFile = { fg = c.overlay2 },
          --- darker
          NvimTreeFolderName = { fg = c.subtext1 },
          NvimTreeOpenedFolderName = { fg = c.subtext1 },

          QuickFixLine = { bg = c.mantle },
          SnacksIndent = { fg = utils.lighten(c.surface0, 0.40, c.base) },
          SnacksIndentScope = { fg = c.surface2 },
          SnacksPickerBoxCursorLine = { bg = bg },
          SnacksPickerCursorLine = { bg = bg },
          SnacksPickerInputCursorLine = { bg = bg },
          SnacksPickerListCursorLine = { bg = bg },
          SnacksPickerMatch = { fg = c.red },
          SnacksPickerPreviewCursorLine = { bg = bg },
          SatelliteBar = { bg = utils.darken(c.maroon, 0.40, c.base) },
          StatusLine = { fg = c.surface0, bg = c.base },
          StatusLineNC = { fg = c.surface0, bg = c.base },
          -- StatusLine = { fg = statusline_fg, bg = statusline_bg },
          -- StatusLineNC = { fg = statusline_fg, bg = statusline_bg },
          TabLine = { bg = c.mantle },
          TreesitterContextBottom = { underline = true },
          TreesitterContextLineNumber = { underline = true },
          TreesitterContextLineNumberBottom = { underline = true },
          -- TreesitterContextBottom = { fg = c.surface0, underline = true },
          -- TreesitterContextLineNumber = { fg = c.surface0, underline = true },
          -- TreesitterContextLineNumberBottom = { fg = c.surface0, underline = true },
          Visual = { bg = utils.darken(c.yellow, 0.20, c.base), style = {} },
          WVisiMatch = { bg = utils.darken(c.red, 0.20, c.base), style = {} },
          WinBar = { fg = c.overlay1 },
          WinBarNC = { fg = c.surface2 },
          WinSeparator = { fg = utils.lighten(c.surface0, 0.40, c.base) },
        }
      end,
    },
  })

  if is_dark then
    vim.cmd("colorscheme catppuccin-frappe")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end

  -- vim.cmd("hi! link FoldColumn LineNr")
end

return M
