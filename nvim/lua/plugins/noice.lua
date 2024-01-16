return {
  "folke/noice.nvim",
  event = { "VeryLazy" },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
      },
      messages = {
        enabled = true,
        view = "messages",           -- default view for messages
        view_error = "messages",     -- view for errors
        view_warn = "messages",      -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
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
    })
  end,
}
