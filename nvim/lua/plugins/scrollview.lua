return {
  {
    "dstein64/nvim-scrollview",
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("scrollview").setup({
        base = "buffer",
        column = 80,
        current_only = false,
        excluded_filetypes = { "NvimTree" },
        signs_on_startup = {},
        winblend = 75,
      })
    end,
  },
}
