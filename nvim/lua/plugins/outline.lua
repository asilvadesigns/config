return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    outline_window = {
      width = 40,
      relative_width = false,
    },
  },
}
