return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  },
  event = { "VeryLazy" },
  config = function()
    require("noice").setup({
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
      views = {
        split = {
          enter = false,
        },
      },
      cmdline = {
        enabled = true,
        format = {
          search_down = {
            icon = "  ",
            kind = "search",
            lang = "regex",
            pattern = "^/",
          },
          search_up = {
            icon = "  ",
            kind = "search",
            lang = "regex",
            pattern = "^%?",
          },
        },
      },
      messages = {
        enabled = true,
        view = "notify",             -- default view for messages
        view_error = "notify",       -- view for errors
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        view_warn = "notify",        -- view for warnings
      },
      notify = {
        enabled = false,
      },
      popupmenu = {
        enabled = true,
      },
      lsp = {
        progress = {
          enabled = true,
        },
      },
      presets = {
        bottom_search = true,
      },
    })
  end,
}
