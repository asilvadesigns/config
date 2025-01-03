local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      fzf = true,
      grug_far = true,
      leap = false,
      notify = false,
      nvimtree = false,
      ufo = false,
    },
    highlight_overrides = {
      latte = function(c)
        local bg = utils.darken(c.surface0, 0.20, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.muave }, -- or c.muave
          CursorLineSign = { bg = bg },
        }
      end,
      frappe = function(c)
        local bg = utils.darken(c.surface0, 0.40, c.base)

        return {
          CursorLine = { bg = bg },
          CursorLineFold = { bg = bg, fg = c.overlay0 }, -- was c.text
          CursorLineNr = { bg = bg, fg = c.muave }, -- or c.overlay2
          CursorLineSign = { bg = bg },
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
          DiagnosticUnderlineError = { sp = c.red, underline = true },
          DiagnosticUnderlineHint = { sp = c.blue, underline = true },
          DiagnosticUnderlineInfo = { sp = c.teal, underline = true },
          DiagnosticUnderlineWarn = { sp = c.yellow, underline = true },
          TelescopeTitle = { fg = c.text },
          TelescopeNormal = { fg = c.subtext0 },

          -- NOTE: use if you want to have no statusline
          StatusLine = { fg = c.surface0, bg = c.base }, -- was c.crust
          StatusLineNC = { fg = c.surface0, bg = c.base }, -- was c.crust

          -- NOTE: use if you want to have a global statusline
          -- StatusLine = { fg = c.overlay1, bg = c.surface0 }, -- was c.crust
          -- StatusLineNC = { fg = c.overlay1, bg = c.surface0 }, -- was c.crust
          --
          WinBar = { fg = c.overlay2 },
          WinBarNC = { fg = c.overlay2 },
          --
          WinSeparator = { fg = c.surface0 },

          NvimTreeFolderName = { fg = c.subtext0 },
          NvimTreeOpenedFolderName = { fg = c.subtext0 },
          NvimTreeNormal = { fg = c.overlay1, bg = c.base },
        }
      end,
    },
  })

  -- # dark
  vim.cmd("colorscheme catppuccin-frappe")
  -- # light
  -- vim.cmd("colorscheme catppuccin-latte")

  vim.cmd("hi! link FoldColumn LineNr")
  vim.cmd("hi! link NvimTreeIndentMarker WinSeparator")
  -- #TODO: you were going to use these to remove the underline
  -- NvimTreeDiagnosticHintIcon      ┃ 1┃NvimTreeDiagnosticHintIcon
  -- NvimTreeDiagnosticInfoIcon      ┃ 1┃NvimTreeDiagnosticInfoIcon
  -- NvimTreeDiagnosticWarnIcon      ┃ 1┃NvimTreeDiagnosticWarnIcon
  -- NvimTreeDiagnosticErrorIcon     ┃ 1┃NvimTreeDiagnosticErrorIcon
  -- NvimTreeDiagnosticHintFileHL    ┃ 1┃NvimTreeDiagnosticHintFileHL
  -- NvimTreeDiagnosticInfoFileHL    ┃ 1┃NvimTreeDiagnosticInfoFileHL
  -- NvimTreeDiagnosticWarnFileHL    ┃ 1┃NvimTreeDiagnosticWarnFileHL
  -- NvimTreeDiagnosticErrorFileHL   ┃ 1┃NvimTreeDiagnosticErrorFileHL
  -- NvimTreeDiagnosticHintFolderHL  ┃ 1┃NvimTreeDiagnosticHintFolderHL
  -- NvimTreeDiagnosticInfoFolderHL  ┃ 1┃NvimTreeDiagnosticInfoFolderHL
  -- NvimTreeDiagnosticWarnFolderHL  ┃ 1┃NvimTreeDiagnosticWarnFolderHL
  -- NvimTreeDiagnosticErrorFolderHL ┃ 1┃NvimTreeDiagnosticErrorFolderHL
end

return M
