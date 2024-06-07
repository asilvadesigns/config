local M = {}

M.setup = function()
  local utils = require("catppuccin.utils.colors")

  require("catppuccin").setup({
    integrations = {
      leap = true,
      notify = true,
      nvimtree = false,
      ufo = true,
    },
    highlight_overrides = {
      latte = function(c)
        local fullCursorLine = utils.lighten(c.surface0, 0.5)
        return {
          CursorLine = { bg = fullCursorLine },
          CursorLineFold = { bg = fullCursorLine, fg = c.overlay0 },
          CursorLineNr = { bg = fullCursorLine, fg = c.mauve },
          CursorLineSign = { bg = fullCursorLine },
          NvimTreeCursorLine = { bg = fullCursorLine },
        }
      end,
      frappe = function(c)
        local fullCursorLine = utils.darken(c.surface0, 0.84)
        return {
          CursorLine = { bg = fullCursorLine },
          CursorLineFold = { bg = fullCursorLine, fg = c.overlay0 },
          CursorLineNr = { bg = fullCursorLine, fg = c.mauve },
          CursorLineSign = { bg = fullCursorLine },
          NvimTreeCursorLine = { bg = fullCursorLine },
        }
      end,
      all = function(c)
        local NotifyBorderGroup = { bg = c.base, fg = c.base }

        return {
          --
          -- custom DEFAULTS
          ScrollView = { bg = c.surface0 },
          Visual = { bg = c.surface0 },
          -- WinSeparator = { fg = c.base }, -- or c.mantle
          WinSeparator = { fg = c.mantle }, -- or c.mantle
          --
          -- NvimTree
          NvimTreeLspDiagnosticsErrorText = { fg = c.red },
          NvimTreeLspDiagnosticsHintText = { fg = c.green },
          NvimTreeLspDiagnosticsInfoText = { fg = c.blue },
          NvimTreeLspDiagnosticsWarnText = { fg = c.yellow },
          --
          -- custom FLASH
          TroubleNormal = { bg = c.base },
          --
          -- custom FLASH
          FlashBackdrop = { fg = c.overlay0 },
          FlashLabel = { fg = c.red, bg = c.crust },
          FlashMatch = { fg = c.lavender, bg = c.base },
          FlashCurrent = { fg = c.sky, bg = c.base },
          FlashPrompt = { link = "NormalFloat" },
          --

          NvimTreeNormal = { fg = c.overlay2 },
          NvimTreeRootFolder = { fg = c.overlay2 },
          NvimTreeFolderName = { fg = c.overlay2 },
          NvimTreeOpenedFolderName = { fg = c.overlay2 },
          NvimTreeFileExec = { fg = c.overlay0 },
          NvimTreeExecFile = { fg = c.overlay0 },
          NvimTreeSpecialFile = { fg = c.overlay0 },

          --
          -- custom NOTIFY
          NotifyBackground = { bg = c.mantle },
          NotifyDEBUGBody = { bg = c.mantle },
          NotifyDEBUGBorder = NotifyBorderGroup,
          NotifyDEBUGIcon = { fg = c.peach },
          NotifyDEBUGTitle = { bg = c.mantle, style = {} },
          NotifyERRORBody = { bg = c.mantle },
          NotifyERRORBorder = NotifyBorderGroup,
          NotifyERRORIcon = { fg = c.red },
          NotifyERRORTitle = { bg = c.mantle, style = {} },
          NotifyINFOBody = { bg = c.mantle },
          NotifyINFOBorder = NotifyBorderGroup,
          NotifyINFOIcon = { fg = c.blue },
          NotifyINFOTitle = { bg = c.mantle, style = {} },
          NotifyTRACEBody = { bg = c.mantle },
          NotifyTRACEBorder = NotifyBorderGroup,
          NotifyTRACEIcon = { fg = c.teal },
          NotifyTRACETitle = { bg = c.mantle, style = {} },
          NotifyWARNBody = { bg = c.mantle },
          NotifyWARNBorder = NotifyBorderGroup,
          NotifyWARNIcon = { fg = c.yellow },
          NotifyWARNTitle = { bg = c.mantle, style = {} },
          --
          -- custom Leap
          -- custom StatusLine
          StatusLine = { bg = c.base },
          StatusLineNC = { bg = c.base },
          --
          -- custom Telescope
          TelescopePreviewTitle = { fg = c.mantle, bg = c.mantle },
          TelescopePromptBorder = { fg = c.mantle, bg = c.mantle },
          TelescopePromptNormal = { bg = c.mantle },
          TelescopePromptTitle = { fg = c.mantle, bg = c.blue },
          TelescopeResultsBorder = { fg = c.mantle, bg = c.mantle },
          TelescopeResultsNormal = { bg = c.mantle },
          TelescopeResultsTitle = { fg = c.mantle, bg = c.mantle },

          -- custom ScrollVie
          ScrollViewCursor = { fg = c.blue },
          --
          -- custom UFO
          Folded = { bg = c.none },
          UfoFoldedEllipsis = { fg = c.mauve, bg = c.none },
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
