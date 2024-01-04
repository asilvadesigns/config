return {
  "aserowy/tmux.nvim",
  enabled = false,
  keys = {
    { "<C-h>", mode = { "n" } },
    { "<C-j>", mode = { "n" } },
    { "<C-k>", mode = { "n" } },
    { "<C-l>", mode = { "n" } },
  },
  config = function()
    require("tmux").setup({
      copy_sync = {
        enable = false,
      },
      navigation = {
        enable_default_keybindings = true,
        cycle_navigation = true,
      },
      resize = {
        enable_default_keybindings = false,
      },
    })
  end,
}
