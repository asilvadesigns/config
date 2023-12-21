require("lazy").setup({
  change_detection = {
    enable = true,
    notify = false,
  },
  checker = {
    enabled = true,
  },
  defaults = {
    autocmds = false,
    keymaps = false,
    lazy = true,
    version = false,
  },
  install = {
    colorscheme = { "onedark" },
  },
  spec = {
    import = "plugins",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
