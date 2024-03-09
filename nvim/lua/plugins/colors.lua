return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "VeryLazy" },
    config = function()
      require("colorizer").setup({})

      vim.cmd("ColorizerAttachToBuffer")
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          notify = true,
          nvimtree = false,
          ufo = true,
        },
        custom_highlights = function(c)
          local NotifyGroup = { bg = c.surface0, fg = c.surface0 }

          return {
            --
            -- custom DEFAULTS
            CursorLine = { bg = c.surface0 },
            CursorLineNr = { fg = c.blue },
            StatusLine = { bg = c.base },
            -- WinSeparator = { fg = colors.base },
            -- WinBar = { bg = colors.mantle },
            --
            -- custom FLASH
            FlashBackdrop = { fg = c.overlay0 },
            FlashLabel = { fg = c.red, bg = c.crust }, -- , style = { "bold" } },
            FlashMatch = { fg = c.lavender, bg = c.base },
            FlashCurrent = { fg = c.sky, bg = c.base },
            FlashPrompt = { link = "NormalFloat" },
            --
            -- custom NOTIFY
            NotifyBackground = { bg = c.surface0 },
            NotifyDEBUGBody = { bg = c.surface0 },
            NotifyDEBUGBorder = NotifyGroup,
            NotifyDEBUGIcon = { fg = c.peach },
            NotifyDEBUGTitle = { bg = c.surface0, style = {} },
            NotifyERRORBody = { bg = c.surface0 },
            NotifyERRORBorder = NotifyGroup,
            NotifyERRORIcon = { fg = c.red },
            NotifyERRORTitle = { bg = c.surface0, style = {} },
            NotifyINFOBody = { bg = c.surface0 },
            NotifyINFOBorder = NotifyGroup,
            NotifyINFOIcon = { fg = c.blue },
            NotifyINFOTitle = { bg = c.surface0, style = {} },
            NotifyTRACEBody = { bg = c.surface0 },
            NotifyTRACEBorder = NotifyGroup,
            NotifyTRACEIcon = { fg = c.teal },
            NotifyTRACETitle = { bg = c.surface0, style = {} },
            NotifyWARNBody = { bg = c.surface0 },
            NotifyWARNBorder = NotifyGroup,
            NotifyWARNIcon = { fg = c.yellow },
            NotifyWARNTitle = { bg = c.surface0, style = {} },
            --
            -- custom UFO
            Folded = { bg = c.none },
            UfoFoldedEllipsis = { fg = c.mauve, bg = c.none },
          }
        end,
      })

      vim.cmd("colorscheme catppuccin-frappe")
      -- vim.cmd("colorscheme catppuccin-latte")
    end,
  },
}
