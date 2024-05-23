return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("notify").setup({
          render = "wrapped-compact",
          stages = "static",
          timeout = 1500,
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
          cmdline = {
            icon = " ",
            lang = "vim",
            pattern = "^:",
            view = "cmdline"
          },
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
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true })
  end,
}
