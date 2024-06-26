local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")
  require("catppuccin").setup({
    integrations = {
      leap = true,
      notify = true,
      nvimtree = false,
      ufo = true,
    },
    highlight_overrides = {
      latte = function (c)
        return {
          CursorLine = { bg = utils.lighten(c.surface0, 0.86) },
          CursorLineNr = { bg = utils.lighten(c.surface0, 0.86) },
        }
      end,
      frappe = function(c)
        return {
          CursorLine = { bg = utils.darken(c.surface0, 0.86) },
          CursorLineNr = { bg = utils.darken(c.surface0, 0.86) },
        }
      end,
      all = function(c)
        return {
          Folded = { bg = c.base },
          -- NvimTreeCursorLine = { bg = c.base, fg = c.text },
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
          -- WinSeparator = { fg = c.base },
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
