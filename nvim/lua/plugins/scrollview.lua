return {
  {
    "dstein64/nvim-scrollview",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("scrollview").setup({
        base = "buffer",
        column = 80,
        current_only = false,
        excluded_filetypes = { "NvimTree" },
        winblend = 75,
      })
    end,
  },
}
