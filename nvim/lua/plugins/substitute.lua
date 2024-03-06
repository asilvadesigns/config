return {
  "gbprod/substitute.nvim",
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
