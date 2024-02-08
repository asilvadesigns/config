return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<leader>x", "<CMD>Oil<CR>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('oil').setup({
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      }
    })
  end,
}
