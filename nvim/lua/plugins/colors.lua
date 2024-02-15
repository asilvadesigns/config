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
      require('catppuccin').setup({
        integrations = {
          nvimtree = false
        }
      })

      vim.cmd("colorscheme catppuccin-frappe")
      -- vim.cmd("colorscheme catppuccin-latte")
    end,
  },
}
