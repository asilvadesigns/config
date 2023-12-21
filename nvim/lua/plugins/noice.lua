return {
  {
    "folke/noice.nvim",
    event = { "VeryLazy" },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = false,
        },
        messages = {
          enabled = false,
        },
        notify = {
          enabled = false,
        },
        popupmenu = {
          enabled = false,
        },
        lsp = {
          progress = {
            enabled = true,
          },
        },
      })
    end,
  },
}
