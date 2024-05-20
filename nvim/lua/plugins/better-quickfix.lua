return {
  "kevinhwang91/nvim-bqf",
  enabled = true,
  dependencies = {
    "junegunn/fzf",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "BqfAutoToggle",
  },
  event = "QuickFixCmdPost" ,
  ft = "qf",
  opts = {
    preview = {
      show_title = true,
    },
  },
}
