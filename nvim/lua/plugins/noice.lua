return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  },
  event = { "VeryLazy" },
  config = function()
    require("noice").setup({
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
      },
      notify = {
        enabled = true,
      },
      popupmenu = {
        enabled = true,
      },
      lsp = {
        progress = { enabled = true },
      },
      presets = {
        bottom_search = true,
      },
      routes = {
        --- show "@recording" messages
        {
          view = "notify",
          filter = {
            event = "msg_showmode",
          },
        },
        --- hide "written" messages
        {
          view = "notify",
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = {
            skip = true,
          },
        }
      }
    })
  end,
}
