return {
  {
    "ggandor/flit.nvim",
    enabled = false,
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      -- vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      -- vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
    -- keys = {
    --   {
    --     ";",
    --     function()
    --       require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
    --     end,
    --     mode = { "n" },
    --   },z
    -- },
  },
  {
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      { "S", false, mode = { "v" } },
      -- {
      --   "S",
      --   mode = { "n", "x", "o" },
      --   function()
      --     require("flash").treesitter()
      --   end,
      --   desc = "Flash Treesitter",
      -- },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
    opts = {},
  },
}
