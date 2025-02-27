local M = {}

M.setup = function()
  local is_dark = true

  local frappe = require("catppuccin.palettes.frappe")
  local utils = require("catppuccin.utils.colors")

  local function desaturate(color, amount)
    local h, s, l = utils.rgb_to_hsl(color)
    s = math.max(0, s - amount) -- Reduce saturation
    return utils.hsl_to_rgb(h, s, l)
  end

  require("catppuccin").setup({
    integrations = {
      bufferline = false,
      fzf = false,
      grug_far = true,
      illuminate = false,
      leap = false,
      notify = false,
      nvimtree = false,
      treesitter = true,
      treesitter_context = false,
      ufo = false,
    },
    color_overrides = {
      latte = {
        base = "#faf4ed",
        mantle = "#ebe5df",
        crust = "#dcd7cd",
        text = "#575279",
        subtext1 = "#5d596f",
        subtext0 = "#6e6a86",
        overlay2 = "#817c9c",
        overlay1 = "#9893a5",
        overlay0 = "#b8b3c7",
        surface2 = "#cecacd",
        surface1 = "#dfdad9",
        surface0 = "#e9e3da",
        red = "#b4637a",
        green = "#618774",
        yellow = "#ea9d34",
        blue = "#286983",
        magenta = "#907aa9",
        cyan = "#56949f",
        lavender = "#907aa9",
        pink = "#d7827e",
        mauve = "#907aa9",
        flamingo = "#d7827e",
        rosewater = "#d7827e",
        peach = "#fe640b",
        teal = "#56949f",
        sky = "#31748f",
        sapphire = "#31748f",
        maroon = "#b4637a",
      },
      frappe = {
        base = "#2e3440",
        mantle = "#292e39",
        crust = "#242933",
        text = "#cdcecf",
        subtext1 = "#b6beca",
        subtext0 = "#a3adc8",
        overlay2 = "#60728a",
        overlay1 = "#5a6884",
        overlay0 = "#545f7e",
        surface2 = "#4c566a",
        surface1 = "#434c5e",
        surface0 = "#3b4252",
        blue = "#81a1c1",
        lavender = "#b48ead",
        sapphire = "#88c0d0",
        sky = "#8fbcbb",
        teal = "#8fbcbb",
        green = "#a3be8c",
        yellow = "#ebcb8b",
        peach = "#d08770",
        maroon = "#bf616a",
        red = "#bf616a",
        mauve = "#b48ead",
        pink = "#b48ead",
        flamingo = "#d08770",
        rosewater = "#e5e9f0",
      },
      -- frappe = {
      --   lavender = utils.darken(frappe.lavender, 0.85, frappe.base),
      --   mauve = utils.darken(frappe.mauve, 0.85, frappe.base),
      --   -- mauve = desaturate(frappe.mauve, 0.1),
      --   green = utils.darken(frappe.green, 0.85, frappe.base),
      --   peach = utils.darken(frappe.peach, 0.85, frappe.base),
      --   yellow = utils.darken(frappe.yellow, 0.85, frappe.base),
      --   --
      --   subtext1 = utils.darken(frappe.subtext1, 0.65, frappe.base),
      --   subtext0 = utils.darken(frappe.subtext0, 0.65, frappe.base),
      --   overlay2 = utils.darken(frappe.overlay2, 0.65, frappe.base),
      --   overlay1 = utils.darken(frappe.overlay1, 0.65, frappe.base),
      --   overlay0 = utils.darken(frappe.overlay0, 0.65, frappe.base),
      --   surface2 = utils.darken(frappe.surface2, 0.65, frappe.base),
      --   surface1 = utils.darken(frappe.surface1, 0.65, frappe.base),
      --   surface0 = utils.darken(frappe.surface0, 0.65, frappe.base),
      --   --
      --   text = utils.darken(frappe.text, 0.85, frappe.base),
      -- },
    },
    highlight_overrides = {
      all = function(c)
        local statusline_bg = c.surface0
        local statusline_fg = c.overlay1

        local bg = utils.darken(c.surface0, 0.40, c.base)

        return {
          ["@constructor.lua"] = { fg = c.subtext0 },
          ["@lsp.type.parameter.typescriptreact"] = { fg = c.subtext1 },
          ["@tag.builtin.tsx"] = { fg = c.mauve },
          -- ["@variable"] = { fg = c.teal },
          ["@variable.builtin"] = { fg = c.lavender },
          ["@variable.parameter"] = { fg = c.lavender },
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
          MatchParen = {
            bg = utils.darken(c.yellow, 0.2, c.base),
            fg = c.yellow,
            style = {},
          },
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
          StatusLine = { fg = c.surface0, bg = c.base },
          StatusLineNC = { fg = c.surface0, bg = c.base },
          -- StatusLine = { fg = statusline_fg, bg = statusline_bg },
          -- StatusLineNC = { fg = statusline_fg, bg = statusline_bg },
          TabLine = { bg = c.mantle },
          TreesitterContextBottom = { fg = c.overlay0, underline = false },
          TreesitterContextLineNumberBottom = { fg = c.overlay0, underline = false },
          Visual = { bg = c.surface1, style = {} },
          WVisiMatch = { bg = c.surface0 },
          WinBar = { fg = c.overlay0 },
          WinBarNC = { fg = c.surface2 },
          WinSeparator = { fg = c.surface0 }, -- or c.base
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
