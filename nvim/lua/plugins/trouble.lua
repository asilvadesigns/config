return {
  {
    "folke/trouble.nvim",
    cmd = { "ToggleTrouble", "Trouble" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      fold_closed = "", -- icon used for closed folds
      fold_open = "", -- icon used for open folds
      use_diagnostic_signs = true,
    },
  },
}