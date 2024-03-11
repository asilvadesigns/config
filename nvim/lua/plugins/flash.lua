return {
  {
    "ggandor/leap.nvim",
    event = { "VeryLazy" },
    keys = {
      {
        ";",
        function()
          require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
        end,
        mode = { "n" },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = { "VeryLazy" },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({})
        end,
        desc = "Flash",
      },
    },
    opts = {
      search = {
        multi_window = false,
      },
      modes = {
        char = {
          keys = { "s" },
          jump_labels = true,
        },
      },
    },
  },
}
