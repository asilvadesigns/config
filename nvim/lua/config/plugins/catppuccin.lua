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
          CursorLineNr = { bg = bg, fg = c.muave }, -- or c.muave
          CursorLineSign = { bg = bg },
        }
      end,
      frappe = function(c)
        local bg = utils.darken(c.surface0, 0.40, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.muave }, -- or c.overlay2
          CursorLineSign = { bg = bg },
        }
      end,
      all = function(c)
        return {
          FloatBorder = { bg = c.base, fg = c.overlay0 },
          Folded = { bg = c.base },
          NormalFloat = { bg = c.base },
          --
          illuminatedWord = { bg = c.surface0 },
          illuminatedCurWord = { bg = c.surface0 },
          --
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          DiagnosticUnderlineError = { sp = c.red, underline = true },
          DiagnosticUnderlineHint = { sp = c.blue, underline = true },
          DiagnosticUnderlineInfo = { sp = c.teal, underline = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, underline = true },

          TelescopeTitle = { fg = c.text },
          TelescopeNormal = { fg = c.subtext0 },

          -- NOTE: use if you want to have no statusline
          -- StatusLine = { fg = c.surface0, bg = c.base }, -- was c.crust
          -- StatusLineNC = { fg = c.surface0, bg = c.base }, -- was c.crust

          -- NOTE: use if you want to have a global statusline
          StatusLine = { fg = c.overlay1, bg = c.base }, -- or c.surface0
          StatusLineNC = { fg = c.overlay1, bg = c.base },
          WDiagnosticSignError = { fg = c.red, bg = c.base },
          WDiagnosticSignHint = { fg = c.blue, bg = c.base },
          WDiagnosticSignInfo = { fg = c.teal, bg = c.base },
          WDiagnosticSignWarn = { fg = c.yellow, bg = c.base },

          --
          WinBar = { fg = c.surface2 },
          WinBarNC = { fg = c.surface2 },
          --
          WinSeparator = { fg = c.surface0 },

          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
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
