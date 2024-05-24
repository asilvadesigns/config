require("lazy").setup("plugins", {
  performance = {
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
  ui = {
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 100,
  },
})
