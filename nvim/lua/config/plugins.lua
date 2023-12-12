require('lazy').setup({
  -- checker = { enabled = false, },
  -- defaults = { lazy = true, },
  -- install = { colorscheme = { "onedark" } },
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
