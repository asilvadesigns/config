local M = {}

vim.api.nvim_set_hl(0, "StatusLineGlobal", {})
vim.api.nvim_set_hl(0, "StatusLineGlobalNC", {})

vim.api.nvim_set_hl(0, "StatusLineLocal", {})
vim.api.nvim_set_hl(0, "StatusLineLocalNC", {})

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      -- treesitter = not _G.enable_simple_colors,
      -- native_lsp = not _G.enable_simple_colors,
      ---
      bufferline = false,
      diffview = true,
      fzf = false,
      grug_far = true,
      illuminate = false,
      leap = false,
      neogit = true,
      notify = false,
      nvimtree = false,
      treesitter_context = false,
      ufo = false,
    },
    color_overrides = {
      latte = require("config.colors").light.dead,
      -- frappe = require("config.colors").dark.dead,
    },
    highlight_overrides = {
      all = function(c)
        local bg = ""
        if _G.enable_dark_theme then
          bg = utils.darken(c.surface0, 0.40, c.base)
        else
          bg = utils.darken(c.yellow, 0.10, c.base)
        end

        local separator_bg = ""
        if _G.enable_dark_theme then
          separator_bg = c.surface0
        else
          separator_bg = utils.lighten(c.surface0, 0.40, c.base)
        end

        local colors = {
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

          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay2 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.surface2 }, -- , fg = c.teal, fg = c.mauve , -- or c.overlay2
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

          IlluminatedWordRead = { bg = utils.darken(c.red, 0.20, c.base), style = {} },
          IlluminatedWordText = { bg = utils.darken(c.red, 0.20, c.base), style = {} },
          IlluminatedWordWrite = { bg = utils.darken(c.red, 0.20, c.base), style = {} },

          NvimTreeCursorLine = { fg = c.blue, bg = bg }, -- or c.base
          -- NvimTreeCursorLine = { bg = bg }, -- or c.base
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
          SatelliteBar = { bg = utils.darken(c.maroon, 0.60, c.base) },
          SnacksIndent = { fg = utils.lighten(c.surface0, 0.40, c.base) },
          SnacksIndentScope = { fg = c.surface2 },
          SnacksPickerBoxCursorLine = { bg = bg },
          SnacksPickerCursorLine = { bg = bg },
          SnacksPickerInputCursorLine = { bg = bg },
          SnacksPickerListCursorLine = { bg = bg },
          SnacksPickerMatch = { fg = c.red },
          SnacksPickerPreviewCursorLine = { bg = bg },

          StatusLineGlobal = { fg = c.overlay1, bg = separator_bg },
          StatusLineGlobalNC = { fg = c.overlay1, bg = separator_bg },
          StatusLineLocal = { fg = separator_bg, bg = c.base },
          StatusLineLocalNC = { fg = separator_bg, bg = c.base },

          TabLine = { bg = c.mantle },
          TreesitterContextBottom = { underline = true },
          TreesitterContextLineNumber = { underline = true },
          TreesitterContextLineNumberBottom = { underline = true },
          Visual = { bg = utils.darken(c.yellow, 0.20, c.base), style = {} },
          WVisiMatch = { bg = utils.darken(c.red, 0.20, c.base), style = {} },
          WinBar = { fg = c.overlay1 },
          WinBarNC = { fg = c.surface2 },
          WinSeparator = { fg = separator_bg },
        }

        if _G.enable_simple_colors then
          colors = vim.tbl_extend("force", colors, {
            ["@comment"] = { fg = c.subtext0, style = {} },
            Comment = { fg = c.subtext0, style = {} },
            --- lsp tokens
            ["@constant"] = { fg = c.text, style = {} },
            ["@field"] = { fg = c.text, style = {} },
            ["@function"] = { fg = c.text, style = {} },
            ["@keyword"] = { fg = c.maroon, style = {} },
            ["@number"] = { fg = c.maroon, style = {} },
            ["@operator"] = { fg = c.text, style = {} },
            ["@property"] = { fg = c.text, style = {} },
            ["@punctuation"] = { fg = c.text, style = {} },
            ["@string"] = { fg = c.green, style = {} },
            ["@type"] = { fg = c.yellow, style = {} },
            ["@variable"] = { fg = c.text, style = {} },
            ["@variable.builtin"] = { fg = c.text, style = {} },
            ["@variable.member"] = { fg = c.text, style = {} },
            ["@variable.parameter"] = { fg = c.text, style = {} },
            --- vim syntax fallback
            Boolean = { fg = c.maroon, style = {} },
            Conditional = { fg = c.maroon, style = {} },
            Constant = { fg = c.text, style = {} },
            Exception = { fg = c.text, style = {} },
            Function = { fg = c.text, style = {} },
            Identifier = { fg = c.maroon, style = {} },
            Include = { fg = c.maroon, style = {} },
            Keyword = { fg = c.maroon, style = {} },
            Label = { fg = c.text, style = {} },
            Number = { fg = c.text, style = {} },
            Operator = { fg = c.maroon, style = {} },
            PreProc = { fg = c.text, style = {} },
            Repeat = { fg = c.maroon, style = {} },
            Special = { fg = c.maroon, style = {} },
            Statement = { fg = c.text, style = {} },
            StorageClass = { fg = c.text, style = {} },
            String = { fg = c.green, style = {} },
            Structure = { fg = c.text, style = {} },
            Title = { fg = c.text, style = {} },
            Type = { fg = c.yellow, style = {} },
          })
        end

        return colors
      end,
    },
  })

  if _G.enable_dark_theme then
    vim.cmd("colorscheme catppuccin-frappe")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end
end

return M
