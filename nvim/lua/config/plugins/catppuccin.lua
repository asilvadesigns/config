local M = {}

M.setup = function()
  local is_dark = true

  -- local frappe = require("catppuccin.palettes.frappe")
  -- local hsluv = require("catppuccin.lib.hsluv")
  local utils = require("catppuccin.utils.colors")

  -- local key = frappe.text

  require("catppuccin").setup({
    integrations = {
      fzf = false,
      grug_far = true,
      illuminate = false,
      leap = false,
      notify = false,
      nvimtree = false,
      treesitter_context = false,
      ufo = false,
    },
    color_overrides = {
      latte = {
        flamingo = "#d7827e", -- Rose
        pink = "#b4637a", -- Love
        mauve = "#907aa9", -- Iris
        red = "#b4637a", -- Love
        maroon = "#d7827e", -- Rose
        peach = "#ea9d34", -- Gold
        yellow = "#ea9d34", -- Gold
        green = "#286983", -- Pine
        teal = "#56949f", -- Foam
        sky = "#56949f", -- Foam
        sapphire = "#56949f", -- Foam
        blue = "#286983", -- Pine
        lavender = "#907aa9", -- Iris
        text = "#575279", -- Text
        -- subtext1 = "#6e6a86", -- Subtle
        -- subtext0 = "#797593", -- Muted
        -- overlay2 = "#908caa", -- Overlay
        -- overlay1 = "#9a97b7", -- Surface1
        -- overlay0 = "#aca9c6", -- Surface2
        -- surface2 = "#b9b6d2", -- Surface2
        -- surface1 = "#e0def4", -- Surface1
        -- surface0 = "#f2e9de", -- Base
        base = "#f2e9de", -- Base
        mantle = "#fffaf3", -- Not explicitly in Rose Pine Dawn, but a lighter shade of Base
        crust = "#fffaf3", -- Same as mantle
      },
      --   frappe = {
      --     flamingo = utils.blend(frappe.flamingo, key, 0.8),
      --     pink = utils.blend(frappe.pink, key, 0.8),
      --     mauve = utils.blend(frappe.mauve, key, 0.8),
      --     red = utils.blend(frappe.red, key, 0.8),
      --     maroon = utils.blend(frappe.maroon, key, 0.8),
      --     peach = utils.blend(frappe.peach, key, 0.8),
      --     yellow = utils.blend(frappe.yellow, key, 0.8),
      --     green = utils.blend(frappe.green, key, 0.8),
      --     teal = utils.blend(frappe.teal, key, 0.8),
      --     sky = utils.blend(frappe.sky, key, 0.8),
      --     sapphire = utils.blend(frappe.sapphire, key, 0.8),
      --     blue = utils.blend(frappe.mauve, key, 0.8),
      --     lavender = utils.blend(frappe.lavender, key, 0.8),
      --     text = utils.blend(frappe.text, key, 0.8),
      --
      --     subtext1 = utils.blend(frappe.subtext1, key, 0.95),
      --     subtext0 = utils.blend(frappe.subtext0, key, 0.95),
      --     overlay2 = utils.blend(frappe.overlay2, key, 0.95),
      --     overlay1 = utils.blend(frappe.overlay1, key, 0.95),
      --     overlay0 = utils.blend(frappe.overlay0, key, 0.95),
      --     surface2 = utils.blend(frappe.surface2, key, 0.95),
      --     surface1 = utils.blend(frappe.surface1, key, 0.95),
      --     surface0 = utils.blend(frappe.surface0, key, 0.95),
      --
      --     base = utils.blend(frappe.base, key, 0.99),
      --     mantle = frappe.mantle,
      --     crust = frappe.crust,
      --   },
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
          ["@tag.builtin.tsx"] = { fg = c.mauve },
          ["@lsp.type.parameter.typescriptreact"] = { fg = c.subtext1 },
          ---
          -- MatchParen = { bg = c.surface1, fg = c.lavender, style = {} },
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.overlay0 }, -- , fg = c.mauve }, -- or c.overlay2
          CursorLineSign = { bg = bg },
          DiagnosticUnderlineError = { sp = c.red, undercurl = true },
          DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
          DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
          DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },
          FloatBorder = { bg = c.base, fg = c.overlay0 },
          Folded = { bg = c.base },
          GrugFarResultsPath = { fg = c.text, bg = c.mantle, underline = true },
          MasonNormal = { bg = c.base },
          NormalFloat = { bg = c.base },
          NvimTreeCursorLine = { fg = c.blue, bg = c.base },
          NvimTreeCursorLineNr = { fg = c.blue, bg = c.base },
          NvimTreeExecFile = { fg = c.overlay1 },
          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeIndentMarker = { fg = c.surface0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeRootFolder = { fg = c.overlay1 },
          NvimTreeSpecialFile = { fg = c.overlay1 },
          QuickFixLine = { bg = c.mantle },
          SnacksIndent = { fg = c.surface0 },
          SnacksIndentScope = { fg = c.surface2 },
          SnacksPickerMatch = { fg = c.red },
          StatusLine = { fg = c.surface2, bg = c.base },
          StatusLineNC = { fg = c.surface2, bg = c.base },
          -- StatusLine = { fg = statusline_fg, bg = statusline_bg },
          -- StatusLineNC = { fg = statusline_fg, bg = statusline_bg },
          TreesitterContextBottom = { fg = c.overlay0, underline = false },
          TreesitterContextLineNumberBottom = { fg = c.overlay0, underline = false },
          Visual = { bg = c.surface1, style = {} },
          WVisiMatch = { bg = c.surface0 },
          WinBar = { fg = c.overlay0 },
          WinBarNC = { fg = c.surface2 },
          WinSeparator = { fg = c.base }, -- or c.surface0
        }
      end,
    },
  })

  -- # dark
  if is_dark then
    vim.cmd("colorscheme catppuccin-frappe")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end

  vim.cmd("hi! link FoldColumn LineNr")
end

return M
