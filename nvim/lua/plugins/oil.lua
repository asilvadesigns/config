return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<leader><space>", "<CMD>Oil<CR>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    delete_to_trash = true,
  },
}
