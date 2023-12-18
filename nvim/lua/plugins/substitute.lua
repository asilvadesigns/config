return {
  {
    "gbprod/substitute.nvim",
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
  },
}
