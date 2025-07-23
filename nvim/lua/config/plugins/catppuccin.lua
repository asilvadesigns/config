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
      markview = true,
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

          -- NvimTreeCursorLine = { fg = c.blue, bg = bg }, -- or c.base
          -- NvimTreeCursorLine = { fg = c.overlay2, bg = bg }, -- or c.base
          -- NvimTreeCursorLineNr = { fg = c.blue, bg = bg }, -- or c.base
          NvimTreeCursorLine = { bg = bg }, -- or c.base
          NvimTreeCursorLineNr = { bg = bg }, -- or c.base
          --- lightest
          NvimTreeIndentMarker = { fg = c.surface0 },
          --- lighter
          NvimTreeExecFile = { fg = c.overlay2 },
          NvimTreeNormal = { fg = c.overlay2, bg = c.base },
          NvimTreeRootFolder = { fg = c.overlay2 },
          NvimTreeSpecialFile = { fg = c.overlay2 },
          --- darker
          NvimTreeFolderName = { fg = c.subtext1 },
          NvimTreeOpenedFolderName = { fg = c.subtext1 },

          QuickFixLine = { bg = c.mantle },
          SatelliteBar = { bg = utils.darken(c.text, 0.60, c.base) },
          SnacksIndent = { fg = utils.lighten(c.surface0, 0.40, c.base) },
          SnacksIndentScope = { fg = c.surface2 },
          SnacksPickerBoxCursorLine = { bg = bg },
          SnacksPickerCursorLine = { bg = bg },
          SnacksPickerInputCursorLine = { bg = bg },
          SnacksPickerListCursorLine = { bg = bg },
          SnacksPickerMatch = { fg = c.red },
          SnacksPickerDir = { fg = c.overlay2 },
          SnacksPickerPreviewCursorLine = { bg = bg },

          StatusLineGlobal = { fg = c.overlay1, bg = separator_bg },
          StatusLineGlobalNC = { fg = c.overlay1, bg = separator_bg },
          StatusLineLocal = { fg = separator_bg, bg = c.base },
          StatusLineLocalNC = { fg = separator_bg, bg = c.base },

          Todo = { fg = c.text, bg = c.base },

          TabLine = { bg = c.mantle },
          TreesitterContextBottom = { underline = true },
          TreesitterContextLineNumber = { underline = true },
          TreesitterContextLineNumberBottom = { underline = true },
          Visual = { bg = utils.darken(c.yellow, 0.20, c.base), style = {} },
          WVisiMatch = { bg = utils.darken(c.red, 0.20, c.base), style = {} },
          WinBar = { fg = c.overlay1 },
          WinBarNC = { fg = c.overlay1 },
          WinSeparator = { fg = separator_bg },
        }

        if _G.enable_simple_colors then
          colors = vim.tbl_extend("force", colors, {
            ["@comment"] = { fg = c.yellow, style = {} }, --- fg = c.subtext0
            Comment = { fg = c.yellow, style = {} }, --- fg = c.subtext0
            --- lsp tokens
            ["@constant"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@constant.builtin"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@constructor"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@constructor.typescript"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@field"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@function"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@function.builtin"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@keyword"] = { fg = c.text, style = {} }, --- fg = c.mauve
            ["@keyword.export"] = { fg = c.text, style = {} }, --- fg = c.mauve
            ["@keyword.function"] = { fg = c.text, style = {} }, --- fg = c.mauve
            ["@keyword.return"] = { fg = c.text, style = {} }, --- fg = c.mauve
            ["@module"] = { fg = c.text, style = {} }, --- fg = c.mauve
            ["@number"] = { fg = c.text, style = {} }, --- fg = c.maroon
            ["@operator"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@property"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@property.class.css"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@property.css"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@punctuation"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@string"] = { fg = c.text, style = {} }, --- fg = c.green
            ["@type"] = { fg = c.text, style = {} }, --- fg = c.yellow
            ["@type.builtin"] = { fg = c.text, style = {} }, --- fg = c.yellow
            ["@type.css"] = { fg = c.text, style = {} }, --- fg = c.yellow
            ["@variable"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@variable.builtin"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@variable.member"] = { fg = c.text, style = {} }, --- fg = c.text
            ["@variable.parameter"] = { fg = c.text, style = {} }, --- fg = c.text
            --- vim syntax fallback
            Boolean = { fg = c.text, style = {} }, --- fg = c.maroon
            Conditional = { fg = c.text, style = {} }, --- fg = c.mauve
            Constant = { fg = c.text, style = {} }, --- fg = c.text
            Exception = { fg = c.text, style = {} }, --- fg = c.text
            Function = { fg = c.text, style = {} }, --- fg = c.maroon
            Identifier = { fg = c.text, style = {} }, --- fg = c.maroon
            Include = { fg = c.text, style = {} }, --- fg = c.maroon
            Keyword = { fg = c.text, style = {} }, --- fg = c.maroon
            Label = { fg = c.text, style = {} }, --- fg = c.text
            Number = { fg = c.text, style = {} }, --- fg = c.text
            Operator = { fg = c.text, style = {} }, --- fg = c.maroon
            PreProc = { fg = c.text, style = {} }, --- fg = c.text
            Repeat = { fg = c.text, style = {} }, --- fg = c.maroon
            Special = { fg = c.text, style = {} }, --- fg = c.maroon
            Statement = { fg = c.text, style = {} }, --- fg = c.text
            StorageClass = { fg = c.text, style = {} }, --- fg = c.text
            String = { fg = c.text, style = {} }, --- fg = c.green
            Structure = { fg = c.text, style = {} }, --- fg = c.text
            Title = { fg = c.text, style = {} }, --- fg = c.text
            Type = { fg = c.text, style = {} }, --- fg = c.yellow
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
