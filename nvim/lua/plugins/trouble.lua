return {
  "folke/trouble.nvim",
  enabled = true,
  branch = "dev",
  cmd = { "ToggleTrouble", "Trouble" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({
      -- fold_closed = "", -- icon used for closed folds
      -- fold_open = "", -- icon used for open folds
      -- indent_lines = false,
      -- padding = false,
      use_diagnostic_signs = true,
    })
  end,
}
