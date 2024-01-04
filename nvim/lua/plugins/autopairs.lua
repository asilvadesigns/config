return {
  "windwp/nvim-autopairs",
  enabled = false,
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup()
  end,
}
