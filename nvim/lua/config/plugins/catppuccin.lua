local M = {}

M.setup = function()
  local is_dark = false

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
        -- base = "#faf4ed",
        -- mantle = "#ebe5df",
        -- crust = "#dcd7cd",
        -- text = "#575279",
        -- subtext1 = "#6e6a86",
        -- subtext0 = "#817c9c",
        -- overlay2 = "#9893a5",
        -- overlay1 = "#b8b3c7",
        -- overlay0 = "#cecacd",
        -- surface2 = "#dfdad9",
        -- surface1 = "#f2e9e1",
        -- surface0 = "#f4ede8",
        -- red = "#b4637a",
        -- green = "#618774",
        -- yellow = "#ea9d34",
        -- blue = "#286983",
        -- magenta = "#907aa9",
        -- cyan = "#56949f",
        -- lavender = "#907aa9",
        -- pink = "#d7827e",
        -- mauve = "#907aa9",
        -- flamingo = "#d7827e",
        -- rosewater = "#d7827e",
        -- peach = "#fe640b",
        -- teal = "#56949f",
        -- sky = "#31748f",
        -- sapphire = "#31748f",
        -- maroon = "#b4637a",
      },
      -- latte = {
      --   rosewater = "#4C566A", -- Polar Night 4 (Darkest accent)
      --   flamingo = "#4C566A", -- Same as rosewater
      --   pink = "#5C7EAB", -- Adjusted Nord blue for better contrast
      --   mauve = "#5C7EAB", -- Same as pink
      --   red = "#B8545F", -- Darker Aurora red for clarity
      --   maroon = "#B8545F", -- Same as red
      --   peach = "#C37C4C", -- Darkened Aurora orange for better legibility
      --   yellow = "#D9B263", -- Slightly deeper Aurora yellow
      --   green = "#8FAF78", -- Adjusted for better contrast
      --   teal = "#7CA5A8", -- Darkened Frost teal for visibility
      --   sky = "#6F9DB8", -- Tweaked Frost light blue
      --   sapphire = "#6B84A3", -- Adjusted Polar Night blue
      --   blue = "#4C7099", -- Darker Nord blue for better UI contrast
      --   lavender = "#6B84A3", -- Same as sapphire
      --   text = "#2E3440", -- Polar Night 0 (Main text, deep blackish-blue)
      --   subtext1 = "#3A414E", -- Darkened slightly for better contrast
      --   subtext0 = "#4A5363", -- More readable than before
      --   overlay2 = "#5E6776", -- Softer but distinguishable
      --   overlay1 = "#717C8D", -- Balanced for UI clarity
      --   overlay0 = "#8590A3", -- Good transition, readable but not overwhelming
      --   surface2 = "#9DA9BA", -- More contrast for UI elements
      --   surface1 = "#B6C0D0", -- Mid-layer UI tone
      --   surface0 = "#CDD5E1", -- Snow Storm 3, softened but still visible
      --   base = "#E5E9F0", -- Snow Storm 2 (Balanced background)
      --   mantle = "#DBE1E8", -- Subtle contrast from base
      --   crust = "#D1D8E0", -- Deepest UI layer for soft depth
      -- },
      -- frappe = {
      --   rosewater = "#D8DEE9", -- Snow Storm 3
      --   flamingo = "#D8DEE9", -- Same as rosewater
      --   pink = "#B48EAD", -- Aurora pink
      --   mauve = "#B48EAD", -- Same as pink
      --   red = "#BF616A", -- Aurora red
      --   maroon = "#BF616A", -- Same as red
      --   peach = "#D08770", -- Aurora orange
      --   yellow = "#EBCB8B", -- Aurora yellow
      --   green = "#A3BE8C", -- Aurora green
      --   teal = "#8FBCBB", -- Frost teal
      --   sky = "#88C0D0", -- Frost light blue
      --   sapphire = "#81A1C1", -- Polar Night blue
      --   blue = "#5E81AC", -- Main Nord blue
      --   lavender = "#81A1C1", -- Same as sapphire
      --   text = "#ECEFF4", -- Snow Storm 1
      --   subtext1 = "#E5E9F0", -- Snow Storm 2 (lighter subtext)
      --   subtext0 = "#D8DEE9", -- Snow Storm 3 (darker subtext)
      --   overlay2 = "#A5ABB6", -- Adjusted for Nord contrast
      --   overlay1 = "#949BA6", -- Closer to Nord’s dim foreground
      --   overlay0 = "#7E8691", -- Soft contrast, better readability
      --   surface2 = "#606874", -- Inspired by Nord's lighter accents
      --   surface1 = "#515965", -- Mid-tone
      --   surface0 = "#434C5E", -- Polar Night 3
      --   base = "#2E3440", -- Main background (Polar Night 0)
      --   mantle = "#3B4252", -- Slightly darker than base (Polar Night 1)
      --   crust = "#242933", -- Custom deeper background
      -- },
      frappe = {
        lavender = utils.darken(frappe.lavender, 0.85, frappe.base),
        mauve = utils.darken(frappe.mauve, 0.85, frappe.base),
        -- mauve = desaturate(frappe.mauve, 0.1),
        green = utils.darken(frappe.green, 0.85, frappe.base),
        peach = utils.darken(frappe.peach, 0.85, frappe.base),
        yellow = utils.darken(frappe.yellow, 0.85, frappe.base),
        --
        subtext1 = utils.darken(frappe.subtext1, 0.65, frappe.base),
        subtext0 = utils.darken(frappe.subtext0, 0.65, frappe.base),
        overlay2 = utils.darken(frappe.overlay2, 0.65, frappe.base),
        overlay1 = utils.darken(frappe.overlay1, 0.65, frappe.base),
        overlay0 = utils.darken(frappe.overlay0, 0.65, frappe.base),
        surface2 = utils.darken(frappe.surface2, 0.65, frappe.base),
        surface1 = utils.darken(frappe.surface1, 0.65, frappe.base),
        surface0 = utils.darken(frappe.surface0, 0.65, frappe.base),
        --
        text = utils.darken(frappe.text, 0.85, frappe.base),
      },
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
