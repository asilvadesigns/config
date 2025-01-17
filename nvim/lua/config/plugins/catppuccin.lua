local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  vim.api.nvim_set_hl(0, "WDiagnosticSignError", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignHint", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignInfo", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignWarn", {})

  require("catppuccin").setup({
    integrations = {
      fzf = true,
      grug_far = true,
      leap = false,
      notify = false,
      nvimtree = false,
      ufo = false,
    },
    highlight_overrides = {
      latte = function(c)
        local bg = utils.darken(c.surface0, 0.20, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.mauve }, -- or c.muave
          CursorLineSign = { bg = bg },
        }
      end,
      frappe = function(c)
        local bg = utils.darken(c.surface0, 0.40, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.mauve }, -- or c.overlay2
          CursorLineSign = { bg = bg },
        }
      end,
      all = function(c)
        -- local statusline_bg = c.base
        -- local statusline_fg = c.surface0
        --
        local statusline_bg = c.surface0
        local statusline_fg = c.overlay1

        return {
          ["@variable.builtin"] = { fg = c.mauve },
          FloatBorder = { bg = c.base, fg = c.overlay0 },
          Folded = { bg = c.base },
          NormalFloat = { bg = c.base },
          --
          illuminatedWord = { bg = c.surface0 },
          illuminatedCurWord = { bg = c.surface0 },
          --
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          DiagnosticUnderlineError = { sp = c.red, underline = true },
          DiagnosticUnderlineHint = { sp = c.teal, underline = true },
          DiagnosticUnderlineInfo = { sp = c.blue, underline = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, underline = true },

          TelescopeTitle = { fg = c.text },
          TelescopeNormal = { fg = c.subtext0 },

          StatusLine = { fg = statusline_fg, bg = statusline_bg },
          StatusLineNC = { fg = statusline_fg, bg = statusline_bg },

          WDiagnosticSignError = { fg = c.red, bg = statusline_bg },
          WDiagnosticSignHint = { fg = c.teal, bg = statusline_bg },
          WDiagnosticSignInfo = { fg = c.blue, bg = statusline_bg },
          WDiagnosticSignWarn = { fg = c.yellow, bg = statusline_bg },

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
        }
      end,
    },
  })

  -- # dark
  vim.cmd("colorscheme catppuccin-frappe")
  -- # light
  -- vim.cmd("colorscheme catppuccin-latte")

  vim.cmd("hi! link FoldColumn LineNr")
  vim.cmd("hi! link NvimTreeIndentMarker WinSeparator")
end

return M
