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
          local NotifyBorderGroup = { bg = c.base, fg = c.base }

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
            -- custom Telescope
            TelescopePreviewTitle = { fg = c.mantle, bg = c.mantle },
            TelescopePromptBorder = { fg = c.mantle, bg = c.mantle },
            TelescopePromptNormal = { bg = c.mantle },
            TelescopePromptTitle = { fg = c.mantle, bg = c.blue },
            TelescopeResultsBorder = { fg = c.mantle, bg = c.mantle },
            TelescopeResultsNormal = { bg = c.mantle },
            TelescopeResultsTitle = { fg = c.mantle, bg = c.mantle },
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
