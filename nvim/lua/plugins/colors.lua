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
        },
        custom_highlights = function(colors)
          return {
            StatusLine = { fg = colors.overlay0 },
          }
        end,
      })

      vim.cmd("colorscheme catppuccin-frappe")
      -- vim.cmd("colorscheme catppuccin-latte")
    end,
  },
}
