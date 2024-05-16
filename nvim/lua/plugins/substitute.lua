return {
  "gbprod/substitute.nvim",
  enabled = true,
  event = { "VeryLazy" },
  keys = {
    {
      "X",
      function()
        require("substitute.exchange").visual()
      end,
      mode = "x",
    },
  },
  opts = {},
}
