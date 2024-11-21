local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  local latte = require("catppuccin.palettes.latte")
  local frappe = require("catppuccin.palettes.frappe")

  -- require("catppuccin").setup()
  require("catppuccin").setup({
    integrations = {
      leap = false,
      notify = false,
      nvimtree = false,
      ufo = false,
    },
    -- highlight_overrides
    color_overrides = {
      frappe = {
        -- rosewater = utils.blue,
        -- flamingo = frappe.blue,
        -- pink = frappe.blue,
        -- -- mauve = frappe.blue,
        -- red = frappe.blue,
        -- maroon = frappe.blue,
        -- peach = frappe.blue,
        -- -- yellow = frappe.blue,
        -- -- green = frappe.blue,
        -- teal = frappe.blue,
        -- sky = frappe.blue,
        -- sapphire = frappe.blue,
        -- blue = frappe.blue,
        -- lavender = frappe.blue,
        --
        --
        -- --
        -- -- rosewater = utils.darken(frappe.rosewater, 0.8),
        -- -- flamingo = utils.darken(frappe.flamingo, 0.8),
        -- -- pink = utils.darken(frappe.pink, 0.8),
        -- -- mauve = utils.darken(frappe.mauve, 0.8),
        -- -- red = utils.darken(frappe.red, 0.8),
        -- -- maroon = utils.darken(frappe.maroon, 0.8),
        -- -- peach = utils.darken(frappe.peach, 0.8),
        -- -- yellow = utils.darken(frappe.yellow, 0.8),
        -- -- green = utils.darken(frappe.green, 0.8),
        -- -- teal = utils.darken(frappe.teal, 0.8),
        -- -- sky = utils.darken(frappe.sky, 0.8),
        -- -- sapphire = utils.darken(frappe.sapphire, 0.8),
        -- -- blue = utils.darken(frappe.blue, 0.8),
        -- -- lavender = utils.darken(frappe.lavender, 0.8),
        -- -- text = utils.darken(frappe.text, 0.8),
        -- -- subtext1 = utils.darken(frappe.subtext1, 0.8),
        -- -- subtext0 = utils.darken(frappe.subtext0, 0.8),
        -- -- overlay2 = utils.darken(frappe.overlay2, 0.8),
        -- -- overlay1 = utils.darken(frappe.overlay1, 0.8),
        -- -- overlay0 = utils.darken(frappe.overlay0, 0.8),
        -- -- surface2 = utils.darken(frappe.surface2, 0.8),
        -- -- surface1 = utils.darken(frappe.surface1, 0.8),
        -- -- surface0 = utils.darken(frappe.surface0, 0.8),
        -- -- base = utils.darken(frappe.base, 0.8),
        -- -- mantle = utils.darken(frappe.mantle, 0.8),
        -- -- crust = utils.darken(frappe.crust, 0.8),
        -- -- flamingo = "#beeecd", -- more sage-like
        -- -- pink = "#b8f4d5", -- mint-like pink
        -- -- mauve = "#9ee6b4", -- green-tinted mauve
        -- -- red = "#82e784", -- less red, more forest
        -- -- maroon = "#99ea9c", -- green-tinted
        -- -- peach = "#76ef8f", -- lime-shifted
        -- -- yellow = "#c8e590", -- more chartreuse
        -- -- green = "#89d18e", -- kept but adjusted
        -- -- teal = "#81e8a4", -- more vibrant green-teal
        -- -- sky = "#99dbb6", -- green-tinted sky
        -- -- sapphire = "#85dca5", -- emerald-like
        -- -- blue = "#8eeea8", -- green-blue
        -- -- lavender = "#baf1bb", -- sage lavender
        -- -- text = "#c6f5d0", -- green-tinted
        -- -- subtext1 = "#b5e2bf",
        -- -- subtext0 = "#a5cea9",
        -- -- overlay2 = "#94bb9a",
        -- -- overlay1 = "#83a789",
        -- -- overlay0 = "#739477",
        -- -- surface2 = "#628066",
        -- -- surface1 = "#516d55",
        -- -- surface0 = "#415946",
        -- -- base = "#304633", -- green-tinted base
        -- -- mantle = "#293c2c", -- darker green
        -- -- crust = "#233426", -- deep forest
      },
      latte = {
        -- rosewater = "#78dc8a", -- shifted green
        -- flamingo = "#78dd8e", -- fresh spring green
        -- pink = "#76ea96", -- mint green
        -- mauve = "#39ef88", -- emerald
        -- red = "#0fd251", -- vibrant green
        -- maroon = "#45e664", -- bright leaf
        -- peach = "#0bfe64", -- lime
        -- yellow = "#1ddf8e", -- jade
        -- green = "#2ba040", -- kept but adjusted
        -- teal = "#179957", -- forest teal
        -- sky = "#04e5a5", -- aqua
        -- sapphire = "#20b57f", -- deep mint
        -- blue = "#1ef566", -- green-blue
        -- lavender = "#72fd8b", -- soft lime
        -- text = "#4c694f", -- green text
        -- subtext1 = "#5c775f",
        -- subtext0 = "#6c856f",
        -- overlay2 = "#7c937f",
        -- overlay1 = "#8ca190",
        -- overlay0 = "#9cb0a0",
        -- surface2 = "#acbeb0",
        -- surface1 = "#bcccc0",
        -- surface0 = "#ccdad0",
        -- base = "#eff5f1", -- slight green tint
        -- mantle = "#e6efea", -- subtle sage
        -- crust = "#dce8e0", -- light moss
      },
    },
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
          -- Visual = { bg = bg, bold = false },
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
          -- Visual = { bg = bg, bold = false },
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
          -- SYNTAX
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
