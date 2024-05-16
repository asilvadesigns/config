return {
  {
    "ggandor/flit.nvim",
    enabled = false,
    event = { "VeryLazy" },
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "nvo",
        multiline = true,
        opts = {},
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
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
    enabled = false,
    event = { "VeryLazy" },
    keys = {
      { "S", false, mode = { "v" } },
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      -- {
      --   "f",
      --   mode = { "n", "x", "o" },
      --   function()
      --     require("flash").jump({})
      --   end,
      --   desc = "Flash",
      -- },
    },
    opts = {
      search = {
        multi_window = false,
      },
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
          jump_labels = true,
        },
      },
    },
  },
}
