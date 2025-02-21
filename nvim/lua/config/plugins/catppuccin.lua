local M = {}

M.setup = function()
  local is_dark = true

  local utils = require("catppuccin.utils.colors")

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
    -- color_overrides = {
    --   latte = {
    --     rosewater = "#dc8a78",
    --     flamingo = "#dd7878",
    --     pink = "#ea76cb",
    --     maroon = "#e64553",
    --     sky = "#04a5e5",
    --     sapphire = "#209fb5",
    --     lavender = "#7287fd",
    --
    --     blue = "#278bd2", --
    --     green = "#859901", --
    --     mauve = "#6c71c4", --
    --     peach = "#cb4c16", --
    --     red = "#dc322f", --
    --     teal = "#2ba198", --
    --     yellow = "#b58801",
    --
    --     text = "#657b83",
    --     subtext1 = utils.darken("#657b83", 0.90, "#eee8d5"),
    --     subtext0 = utils.darken("#657b83", 0.85, "#eee8d5"),
    --     overlay2 = utils.darken("#657b83", 0.80, "#eee8d5"),
    --     overlay1 = utils.darken("#657b83", 0.75, "#eee8d5"),
    --     overlay0 = utils.darken("#657b83", 0.70, "#eee8d5"),
    --     surface2 = utils.darken("#657b83", 0.65, "#eee8d5"),
    --     surface1 = utils.darken("#657b83", 0.60, "#eee8d5"),
    --     surface0 = utils.darken("#657b83", 0.55, "#eee8d5"),
    --     base = "#eee8d5",
    --     mantle = "#eee8d5",
    --     crust = "#eee8d5",
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
