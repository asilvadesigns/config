return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
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
        view = "mini", -- default view for messages
        view_error = "mini", -- view for errors
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        view_warn = "mini", -- view for warnings
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
        -- --
        -- {
        --   filter = {
        --     event = "msg_show",
        --     kind = "",
        --   },
        --   opts = { skip = true },
        -- },
        -- show "@recording" messages
        {
          view = "notify",
          filter = {
            event = "msg_showmode",
          },
        },
        -- hide "written" messages
        {
          view = "notify",
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    })

    vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true })
  end,
}
