return {
  "folke/noice.nvim",
  event = { "VeryLazy" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      -- dependencies = { "catppuccin/nvim" },
      config = function()
        -- local colors = require("catppuccin.palettes").get_palette()
        require("notify").setup({
          render = "minimal",
          top_down = false,
        })
      end,
    },
  },
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
        enabled = false,
      },
      notify = {
        enabled = false,
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
        -- -- show "@recording" messages
        -- { view = "notify", filter = { event = "msg_showmode" } },
        { view = "notify", filter = { event = "msg_show", find = "No information available" }, opts = { skip = true } },
        { view = "notify", filter = { event = "msg_show", find = "written" }, opts = { skip = true } },
      },
    })

    vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true })
  end,
}
