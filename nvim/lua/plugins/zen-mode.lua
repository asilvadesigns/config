return {
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = {
      "NoNeckPain",
      "NoNeckPainWidthDown",
      "NoNeckPainWidthUp",
    },
    version = "*",
    config = function()
      require("no-neck-pain").setup({
        width = 120,
      })
    end,
  },
}
