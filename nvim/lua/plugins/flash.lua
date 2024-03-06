return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        -- keys = { "f", "F", "t", "T", [";"] = ";", [","] = "<c-;>" },
        keys = {},
      },
    },
  },
  keys = {
    -- -- I use these...
    -- { "f", mode = "n" },
    -- { "F", mode = "n" },
    -- { "t", mode = "n" },
    -- { "T", mode = "n" },
    -- Not these...
    -- { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    -- { "<c-;>", mode = { "n" }, function() require("flash").jump() end, desc = "Toggle Flash Jump" }
    {
      ";",
      mode = { "n" },
      function()
        require("flash").jump({
          search = {
            forward = true,
            multi_window = false,
            wrap = true,
          },
          modes = {
            char = {
              jump_labels = true,
            },
          },
        })
      end,
      desc = "Toggle Flash Jump",
    },
  },
}
