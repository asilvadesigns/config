local M = {}

M.setup = function()
  local is_dark = true

  local utils = require("catppuccin.utils.colors")
  -- local frappe = require("catppuccin.palettes.frappe")
  --

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
    -- color_overrides = {
    --   frappe = {
    --     flamingo = utils.darken(frappe.flamingo, 0.8, frappe.base),
    --     pink = utils.darken(frappe.pink, 0.8, frappe.base),
    --     mauve = utils.darken(frappe.mauve, 0.8, frappe.base),
    --     red = utils.darken(frappe.red, 0.8, frappe.base),
    --     maroon = utils.darken(frappe.maroon, 0.8, frappe.base),
    --     peach = utils.darken(frappe.peach, 0.8, frappe.base),
    --     yellow = utils.darken(frappe.yellow, 0.8, frappe.base),
    --     green = utils.darken(frappe.green, 0.8, frappe.base),
    --     teal = utils.darken(frappe.teal, 0.8, frappe.base),
    --     sky = utils.darken(frappe.sky, 0.8, frappe.base),
    --     sapphire = utils.darken(frappe.sapphire, 0.8, frappe.base),
    --     blue = utils.darken(frappe.blue, 0.8, frappe.base),
    --     lavender = utils.darken(frappe.lavender, 0.8, frappe.base),
    --     text = utils.darken(frappe.text, 0.8, frappe.base),
    --     -- subtext1 = utils.darken(frappe.subtext1, 0.8, frappe.subtext1),
    --     -- subtext0 = utils.darken(frappe.subtext0, 0.8, frappe.subtext0),
    --     -- overlay2 = utils.darken(frappe.overlay2, 0.8, frappe.overlay2),
    --     -- overlay1 = utils.darken(frappe.overlay1, 0.8, frappe.overlay1),
    --     -- overlay0 = utils.darken(frappe.overlay0, 0.8, frappe.overlay0),
    --     -- surface2 = utils.darken(frappe.surface2, 0.8, frappe.surface2),
    --     -- surface1 = utils.darken(frappe.surface1, 0.8, frappe.surface1),
    --     -- surface0 = utils.darken(frappe.surface0, 0.8, frappe.surface0),
    --     -- base = frappe.base,
    --     -- mantle = frappe.mantle,
    --     -- crust = frappe.crust,
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

          WDiagnosticSignError = { fg = c.red, bg = statusline_bg },
          WDiagnosticSignHint = { fg = c.teal, bg = statusline_bg },
          WDiagnosticSignInfo = { fg = c.blue, bg = statusline_bg },
          WDiagnosticSignWarn = { fg = c.yellow, bg = statusline_bg },
          WVisiMatch = { bg = c.surface0 },

          --
          WinBar = { fg = c.overlay0 },
          WinBarNC = { fg = c.surface2 },
          --
          WinSeparator = { fg = c.surface0 },

          NvimTreeExecFile = { fg = c.overlay1 },
          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeRootFolder = { fg = c.overlay1 },
          NvimTreeSpecialFile = { fg = c.overlay1 },

          SnacksPickerMatch = { fg = c.red },
          SnacksIndentScope = { fg = c.surface2 },
        }
      end,
    },
  })

  -- Prevent LSP from overwriting treesitter color settings
  -- https://github.com/NvChad/NvChad/issues/1907
  -- vim.highlight.priorities.semantic_tokens = 95

  -- # dark
  if is_dark then
    vim.cmd("colorscheme catppuccin-frappe")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end

  vim.cmd("hi! link FoldColumn LineNr")
  vim.cmd("hi! link NvimTreeIndentMarker WinSeparator")
end

return M
