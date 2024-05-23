return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          leap = true,
          notify = true,
          nvimtree = false,
          ufo = true,
        },
        custom_highlights = function(c)
          local NotifyBorderGroup = { bg = c.base, fg = c.base }

          -- local fullCursorLine = c.surface0
          local fullCursorLine = c.base

          local group01 = c.overlay2
          local group02 = c.overlay2
          local group03 = c.overlay2
          -- local group01 = c.overlay2
          -- local group02 = c.overlay1
          -- local group03 = c.text

          return {
            --
            -- custom DEFAULTS
            CursorLine = { bg = fullCursorLine },
            CursorLineFold = { bg = fullCursorLine, fg = c.subtext1 },
            CursorLineNr = { bg = fullCursorLine, fg = c.blue },
            -- CursorLineNr = { bg = fullCursorLine, fg = c.overlay0 },
            CursorLineSign = { bg = fullCursorLine },
            ScrollView = { bg = c.surface0 },
            Visual = { bg = c.surface0 },
            WinSeparator = { fg = c.mantle },
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
            NvimTreeNormal = { fg = group01 },
            NvimTreeRootFolder = { fg = group01 },
            NvimTreeFolderName = { fg = group03 },
            NvimTreeOpenedFolderName = { fg = group03 },
            -- NvimTreeFolderArrowOpen = { fg = c.blue },

            NvimTreeFileExec = { fg = group02 },
            NvimTreeExecFile = { fg = group02 },
            NvimTreeSpecialFile = { fg = group02 },

            NvimTreeCursorLine = { bg = c.surface0 },
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
      })

      -- # dark
      vim.cmd("colorscheme catppuccin-frappe")
      -- # light
      -- vim.cmd("colorscheme catppuccin-latte")
    end,
  },
}
