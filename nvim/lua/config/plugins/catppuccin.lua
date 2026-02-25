---@diagnostic disable: missing-fields

local M = {}

vim.api.nvim_set_hl(0, "StatusLineGlobal", {})
vim.api.nvim_set_hl(0, "StatusLineGlobalNC", {})

vim.api.nvim_set_hl(0, "StatusLineLocal", {})
vim.api.nvim_set_hl(0, "StatusLineLocalNC", {})

local toggle = function()
  if _G.enable_syntax_highlight then
    vim.cmd("colorscheme catppuccin-latte")
  else
    vim.cmd("colorscheme catppuccin-frappe")
  end
end

--- @class c CtpColors<T>: {rosewater: T, flamingo: T, pink: T, mauve: T, red: T, maroon: T, peach: T, yellow: T, green: T, teal: T, sky: T, sapphire: T, blue: T, lavender: T, text: T, subtext1: T, subtext0: T, overlay2: T, overlay1: T, overlay0: T, surface2: T, surface1: T, surface0: T, base: T, mantle: T, crust: T, none: T }
--- @param bg string
--- @param separator_bg string
local get_colors = function(c, bg, separator_bg)
  local utils = require("catppuccin.utils.colors")

  return {
    ["@constructor.lua"] = { fg = c.subtext0 },
    ["@property.json"] = { fg = c.text },
    ["@punctuation.bracket"] = { fg = c.subtext0 },
    ["@punctuation.special.typescript"] = { fg = c.subtext0 },

    CursorLine = { bg = bg },
    CursorLineFold = { bg = bg, fg = c.overlay2 }, -- was c.text
    CursorLineNr = { bg = bg, fg = c.surface2 },   -- , fg = c.teal, fg = c.mauve , -- or c.overlay2
    CursorLineSign = { bg = bg },

    DiagnosticUnderlineError = { sp = c.red, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
    DiagnosticUnnecessary = { fg = c.overlay2, sp = c.overlay2 },

    FloatBorder = { bg = c.base, fg = c.overlay0 },
    Folded = { bg = c.base },
    FoldColumn = { fg = c.red },
    LineNr = { fg = c.surface2 }, -- could remove?
    SignColumn = { fg = c.red },
    MasonNormal = { bg = c.base },
    MasonBackdrop = { bg = "#0000FF" },
    MatchParen = {
      bg = utils.darken(c.yellow, 0.2, c.base),
      fg = c.yellow,
      style = {},
    },
    NormalFloat = { bg = c.base },

    IlluminatedWordRead = { bg = utils.darken(c.blue, 0.20, c.base), style = {} },  -- c.red
    IlluminatedWordText = { bg = utils.darken(c.blue, 0.20, c.base), style = {} },  -- c.red
    IlluminatedWordWrite = { bg = utils.darken(c.blue, 0.20, c.base), style = {} }, -- c.red

    NvimTreeCursorLine = { bg = bg },                                               -- or c.base
    NvimTreeCursorLineNr = { bg = bg },                                             -- or c.base
    --- lightest
    NvimTreeIndentMarker = { fg = c.surface0 },
    --- lighter
    NvimTreeExecFile = { fg = c.overlay2 },
    NvimTreeNormal = { fg = c.overlay2, bg = c.base },
    NvimTreeRootFolder = { fg = c.overlay2 },
    NvimTreeSpecialFile = { fg = c.overlay2 },
    --- darker
    NvimTreeFolderName = { fg = c.subtext1 },
    NvimTreeOpenedFolderName = { fg = c.subtext1 },

    QuickFixLine = { bg = c.mantle },
    SatelliteBar = { bg = utils.darken(c.text, 0.60, c.base) },
    SnacksIndent = { fg = c.surface0 }, --utils.lighten(c.surface0, 0.40, c.base) },
    SnacksIndentScope = { fg = c.surface2 },
    SnacksPickerBoxCursorLine = { bg = bg },
    SnacksPickerCursorLine = { bg = bg },
    SnacksPickerInputCursorLine = { bg = bg },
    SnacksPickerListCursorLine = { bg = bg },
    SnacksPickerMatch = { fg = c.red },
    SnacksPickerDir = { fg = c.overlay2 },
    SnacksPickerPreviewCursorLine = { bg = bg },

    StatusLineGlobal = { fg = c.overlay1, bg = separator_bg },
    StatusLineGlobalNC = { fg = c.overlay1, bg = separator_bg },
    StatusLineLocal = { fg = separator_bg, bg = c.base },
    StatusLineLocalNC = { fg = separator_bg, bg = c.base },

    Todo = { fg = c.text, bg = c.base },

    TabLine = { bg = c.mantle },
    TreesitterContextBottom = { underline = true },
    TreesitterContextLineNumber = { underline = true },
    TreesitterContextLineNumberBottom = { underline = true },
    Visual = { bg = utils.darken(c.yellow, 0.20, c.base), style = {} },
    WVisiMatch = { bg = utils.darken(c.blue, 0.20, c.base), style = {} }, -- OR c.red
    WinBar = { fg = c.overlay1 },
    WinBarNC = { fg = c.overlay1 },
    WinSeparator = { fg = separator_bg },
  }
end

--- NOTE: what is going on here!? why remapping latte and frappe?
--- because I'm using overriding them to be:
--- latte:  chromatic
--- frappe: monochrome
---
--- @return CtpFlavors
local overrides = function()
  if (_G.enable_dark_mode) then
    return {
      latte = require("catppuccin.palettes.frappe"),
      frappe = require("catppuccin.palettes.frappe"),
      -- latte = require("config.colors").dark.solarized,
      -- frappe = require("config.colors").dark.solarized,
    }
  end

  return {
    latte = require("config.colors").light.dead,
    frappe = require("config.colors").light.dead,
  }
end

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      default_integrations = false,
      diffview = true,
      grug_far = true,
      neogit = true,
      nvimtree = false,
      treesitter_context = false,
      ufo = false,
    },
    color_overrides = overrides(),
    highlight_overrides = {
      latte = function(c)
        -- local bg = utils.darken(c.surface0, 0.80, c.base)
         bg = utils.darken(c.yellow, 0.10, c.base)

        local separator_bg = utils.darken(c.surface1, 0.30, c.base)
        -- local separator_bg = utils.darken(c.yellow, 0.14, c.base)
        local colors = get_colors(c, bg, separator_bg)

        return colors
      end,
      frappe = function(c)
        local bg = utils.darken(c.surface0, 0.80, c.base)
        -- local bg = utils.darken(c.yellow, 0.10, c.base)

        -- local separator_bg = c.surface0
        local separator_bg = utils.darken(c.surface1, 0.30, c.base)
        -- local separator_bg = utils.darken(c.yellow, 0.14, c.base)
        local emphasis = { fg = c.text, style = {}, bold = false }
        local mono = { fg = c.text, style = {} }
        local colors = get_colors(c, bg, separator_bg)

        -- Monochrome groups (all use fg = c.text)
        local mono_groups = {
          "@constant", "@constant.builtin", "@constructor", "@constructor.typescript",
          "@field", "@function", "@function.builtin",
          "@keyword.export", "@keyword.function", "@keyword.operator",
          "@keyword.jsdoc", "@module", "@number", "@operator",
          "@property", "@property.class.css", "@property.css", "@punctuation",
          "@string", "@type", "@type.builtin", "@type.css",
          "@variable", "@variable.builtin", "@variable.member", "@variable.parameter",
          "Boolean", "Constant", "Function", "Identifier", "Include", "Keyword",
          "Label", "Number", "Operator", "PreProc", "Special", "Statement",
          "StorageClass", "String", "Structure", "Title", "Todo", "Type",
        }
        for _, group in ipairs(mono_groups) do
          colors[group] = mono
        end

        -- Groups with different values
        colors["@comment"] = { fg = c.yellow, style = {} }
        colors["Comment"] = { fg = c.yellow, style = {} }
        colors["@nospell.jsdoc"] = { fg = c.yellow, style = {} }
        colors["@keyword"] = emphasis
        colors["@keyword.return"] = emphasis
        colors["Conditional"] = emphasis
        colors["Exception"] = emphasis
        colors["Repeat"] = emphasis

        return colors
      end,
    },
  })

  toggle()
  vim.api.nvim_create_user_command("ToggleSyntaxHighlight", function()
    _G.enable_syntax_highlight = not _G.enable_syntax_highlight
    toggle()
  end, {})
end

return M
