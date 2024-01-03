return {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = { "VeryLazy" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          highlight = { "Comment" },
          char = "▏",
        },
      })
    end,
  },
}
