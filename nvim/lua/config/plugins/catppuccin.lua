local M = {}

M.setup = function()
  local is_dark = true

  -- local frappe = require("catppuccin.palettes.frappe")
  -- local hsluv = require("catppuccin.lib.hsluv")
  local utils = require("catppuccin.utils.colors")

  vim.api.nvim_set_hl(0, "WDiagnosticSignError", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignHint", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignInfo", {})
  vim.api.nvim_set_hl(0, "WDiagnosticSignWarn", {})
  vim.api.nvim_set_hl(0, "WVisiMatch", {})

  -- local key = frappe.text

  require("catppuccin").setup({
    integrations = {
      fzf = true,
      grug_far = true,
      illuminate = true,
      leap = false,
      notify = false,
      nvimtree = false,
      treesitter_context = false,
      ufo = false,
    },
    -- color_overrides = {
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
    -- },
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
          -- MatchParen = { bg = c.surface1, fg = c.lavender, style = {} },
          Visual = { bg = c.surface1, style = {} },
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
          -- StatusLine = { fg = c.surface2, bg = c.base },
          -- StatusLineNC = { fg = c.surface2, bg = c.base },

          WDiagnosticSignError = { fg = c.red, bg = statusline_bg },
          WDiagnosticSignHint = { fg = c.teal, bg = statusline_bg },
          WDiagnosticSignInfo = { fg = c.blue, bg = statusline_bg },
          WDiagnosticSignWarn = { fg = c.yellow, bg = statusline_bg },
          WVisiMatch = { bg = c.surface0 },

          WinBar = { fg = c.overlay0 },
          WinBarNC = { fg = c.surface2 },
          SnacksIndent = { fg = c.surface0 },
          WinSeparator = { fg = c.surface0 },
          -- WinSeparator = { fg = c.base },

          NvimTreeExecFile = { fg = c.overlay1 },
          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeIndentMarker = { fg = c.surface0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeRootFolder = { fg = c.overlay1 },
          NvimTreeSpecialFile = { fg = c.overlay1 },

          SnacksPickerMatch = { fg = c.red },
          SnacksIndentScope = { fg = c.surface2 },

          TreesitterContextBottom = { fg = c.overlay0, underline = false },
          TreesitterContextLineNumberBottom = { fg = c.overlay0, underline = false },
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
