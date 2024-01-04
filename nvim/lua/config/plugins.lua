require("lazy").setup("plugins", {
  change_detection = {
    enable = true,
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  defaults = {
    autocmds = false,
    keymaps = false,
    lazy = true,
    version = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
