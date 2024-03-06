return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "VeryLazy" },
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
          nvimtree = false,
          ufo = true,
        },
        custom_highlights = function(colors)
          return {
            CursorLine = { bg = colors.base },
            CursorLineNr = { fg = colors.blue },
            StatusLine = { bg = colors.base },
            WinSeparator = { fg = colors.base },
            --
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
