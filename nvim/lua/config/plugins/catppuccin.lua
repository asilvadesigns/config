local M = {}

M.setup = function()
  -- local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      leap = true,
      notify = true,
      nvimtree = false,
      ufo = true,
    },
    highlight_overrides = {
      latte = function(c)
        -- local otherbg = utils.lighten(c.surface0, 0.86)
        local bg = c.base

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.text },
          CursorLineNr = { bg = bg, fg = c.mauve },
          CursorLineSign = { bg = bg },
          --
          NvimTreeCursorLine = { fg = c.subtext1 },
        }
      end,
      frappe = function(c)
        -- local otherbg = utils.darken(c.surface0, 0.86)
        local bg = c.base

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.text },
          CursorLineNr = { bg = bg, fg = c.mauve },
          CursorLineSign = { bg = bg },
          --
          NvimTreeCursorLine = { fg = c.subtext1 },
        }
      end,
      all = function(c)
        return {
          FloatBorder = { bg = c.base },
          Folded = { bg = c.base },
          --
          illuminatedWord = { bg = c.surface0 },
          illuminatedCurWord = { bg = c.surface0 },
          --
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          DiagnosticUnderlineError = { sp = c.red, undercurl = true },
          DiagnosticUnderlineHint = { sp = c.blue, undercurl = true },
          DiagnosticUnderlineInfo = { sp = c.teal, undercurl = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
          --
          StatusLine = { fg = c.crust, bg = c.base },
          StatusLineNC = { fg = c.crust, bg = c.base },
          --
          -- NvimTreeNormal = { bg = c.mantle },
          --
          WinBar = { fg = c.overlay2 },
          WinBarNC = { fg = c.overlay2 },
          --
          WinSeparator = { fg = c.base },
        }
      end,
    },
  })

  -- # dark
  vim.cmd("colorscheme catppuccin-frappe")
  -- # light
  -- vim.cmd("colorscheme catppuccin-latte")
end

return M
