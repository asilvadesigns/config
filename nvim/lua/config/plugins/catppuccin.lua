local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  vim.api.nvim_set_hl(0, "WDiagnosticSignError", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignHint", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignInfo", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignWarn", {})
  vim.api.nvim_set_hl(0, "WVisiMatch", {})

  require("catppuccin").setup({
    integrations = {
      fzf = true,
      grug_far = true,
      leap = false,
      illuminate = true,
      notify = false,
      nvimtree = false,
      ufo = false,
    },
    highlight_overrides = {
      all = function(c)
        local statusline_bg = c.surface0
        local statusline_fg = c.overlay1

        local bg = utils.darken(c.surface0, 0.40, c.base)

        return {
          ["@constructor.lua"] = { fg = c.subtext0 },
          ["@variable.builtin"] = { fg = c.lavender },
          ["@variable.parameter"] = { fg = c.lavender },
          FloatBorder = { bg = c.base, fg = c.overlay0 },
          Folded = { bg = c.base },
          NormalFloat = { bg = c.base },
          ---
          ---
          ---
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.overlay0 }, -- , fg = c.mauve }, -- or c.overlay2
          CursorLineSign = { bg = bg },
          ---
          -- MatchParen = { bg = c.surface1, style = {} },
          Visual = { bg = c.surface1, style = {} },
          --
          -- illuminatedWord = { bg = c.mauve },
          -- illuminatedCurWord = { bg = c.mauve },
          --
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          DiagnosticUnderlineError = { sp = c.red, undercurl = true },
          DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
          DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },

          TelescopeTitle = { fg = c.text },
          TelescopeNormal = { fg = c.subtext0 },

          GrugFarResultsPath = { fg = c.text, bg = c.mantle, underline = true },

          StatusLine = { fg = statusline_fg, bg = statusline_bg },
          StatusLineNC = { fg = statusline_fg, bg = statusline_bg },

          WDiagnosticSignError = { fg = c.red, bg = statusline_bg },
          WDiagnosticSignHint = { fg = c.teal, bg = statusline_bg },
          WDiagnosticSignInfo = { fg = c.blue, bg = statusline_bg },
          WDiagnosticSignWarn = { fg = c.yellow, bg = statusline_bg },
          WVisiMatch = { bg = c.surface0 },

          --
          WinBar = { fg = c.surface2 },
          WinBarNC = { fg = c.surface2 },
          --
          WinSeparator = { fg = c.surface0 },

          NvimTreeExecFile = { fg = c.overlay1 },
          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeSpecialFile = { fg = c.overlay1 },

          SnacksPickerMatch = { fg = c.red },
        }
      end,
    },
  })

  -- Prevent LSP from overwriting treesitter color settings
  -- https://github.com/NvChad/NvChad/issues/1907
  vim.highlight.priorities.semantic_tokens = 95

  -- # dark
  vim.cmd("colorscheme catppuccin-frappe")
  -- # light
  -- vim.cmd("colorscheme catppuccin-latte")

  vim.cmd("hi! link FoldColumn LineNr")
  vim.cmd("hi! link NvimTreeIndentMarker WinSeparator")
end

return M
