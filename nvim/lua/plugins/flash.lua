return {
  {
    "ggandor/flit.nvim",
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
    enabled = false,
    keys = {
      -- { "S", false, mode = {"v"} },
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
          -- keys = { "s" },
          jump_labels = true,
        },
      },
    },
  },
}
