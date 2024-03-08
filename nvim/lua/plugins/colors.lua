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
          notify = false,
          nvimtree = false,
          ufo = true,
        },
        custom_highlights = function(colors)
          return {
            --
            -- custom DEFAULTS
            CursorLine = { bg = colors.surface },
            CursorLineNr = { fg = colors.blue },
            StatusLine = { bg = colors.base },
            -- WinSeparator = { fg = colors.base },
            -- WinBar = { bg = colors.mantle },
            --
            -- custom FLASH
            FlashBackdrop = { fg = colors.overlay0 },
            FlashLabel = { fg = colors.red, bg = colors.crust }, -- , style = { "bold" } },
            FlashMatch = { fg = colors.lavender, bg = colors.base },
            FlashCurrent = { fg = colors.sky, bg = colors.base },
            FlashPrompt = { link = "NormalFloat" },
            --
            -- custom UFO
            Folded = { bg = colors.none },
            UfoFoldedEllipsis = { fg = colors.mauve, bg = colors.none },
          }
        end,
      })

      vim.cmd("colorscheme catppuccin-frappe")
      -- vim.cmd("colorscheme catppuccin-latte")
    end,
  },
}
