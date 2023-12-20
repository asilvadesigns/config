return {
  {
    "folke/which-key.nvim",
    enabled = false,
    event = { "VeryLazy" },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
}
