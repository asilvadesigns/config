return {
  "stevearc/aerial.nvim",
  cmd = {
    "AerialNavOpen",
    "AerialOpen",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    layout = {
      disable_max_size = 4000000, -- Default 2MB.. bumped to 4MB
      min_width = 30,
    },
  },
}
