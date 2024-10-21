local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      leap = false,
      notify = false,
      nvimtree = false,
      ufo = false,
    },
    -- highlight_overrides
    -- color_overrides = {},
    highlight_overrides = {
      latte = function(c)
        -- local bg = c.base
        local bg = utils.darken(c.surface0, 0.20, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.overlay0 }, -- or c.muave
          CursorLineSign = { bg = bg },
          --
          NvimTreeCursorLine = { bg = bg, fg = c.text },
          Visual = { bg = bg, bold = false },
        }
      end,
      frappe = function(c)
        -- local bg = c.base
        local bg = utils.darken(c.surface0, 0.40, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.overlay0 }, -- or c.muave
          CursorLineSign = { bg = bg },
          --
          NvimTreeCursorLine = { bg = bg, fg = c.text },
          Visual = { bg = bg, bold = false },
        }
      end,
      all = function(c)
        return {
          FloatBorder = { bg = c.base, fg = c.overlay0 },
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
          TelescopeTitle = { fg = c.text },
          --
          -- StatusLine = { fg = c.surface2, bg = c.mantle },
          -- StatusLineNC = { fg = c.surface2, bg = c.mantle },

          -- NOTE: use if you want to have no statusline
          -- StatusLine = { fg = c.surface0, bg = c.base }, -- was c.crust
          -- StatusLineNC = { fg = c.surface0, bg = c.base }, -- was c.crust

          -- NOTE: use if you want to have a global statusline
          StatusLine = { fg = c.surface2, bg = c.base }, -- was c.crust
          StatusLineNC = { fg = c.surface2, bg = c.base }, -- was c.crust
          --
          WinBar = { fg = c.overlay2 },
          WinBarNC = { fg = c.overlay2 },
          --
          WinSeparator = { fg = c.surface0 },
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
