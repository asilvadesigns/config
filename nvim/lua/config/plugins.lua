require('lazy').setup({
  checker = { enabled = false, },
  defaults = { lazy = true, },
  install = { colorscheme = { "solarized-flat" } },
  spec = { import = 'plugins' },
  performance = {
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
      }
    }
  },
})

