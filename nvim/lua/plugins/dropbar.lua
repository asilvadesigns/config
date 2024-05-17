return {
  {
    "Bekaboo/dropbar.nvim",
    enabled = false,
    event = { "VeryLazy" },
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require("dropbar").setup()

      vim.keymap.set("n", "<leader><space>", function()
        require("dropbar.api").pick()
      end, {})
    end,
  },
}
