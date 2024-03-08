return {
  "folke/noice.nvim",
  event = { "VeryLazy" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      dependencies = { "catppuccin/nvim" },
      config = function()
        local colors = require("catppuccin.palettes").get_palette()

        require("notify").setup({
          background_colour = colors.surface0,
          render = "minimal",
          timeout = 1000,
          top_down = false,
        })

        -- local NotifyPrompt = {
        --   NotifyBackground = {
        --     bg = colors.surface0,
        --   },
        -- }
        --
        -- for hl, col in pairs(NotifyPrompt) do
        --   vim.api.nvim_set_hl(0, hl, col)
        -- end
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
    })

    vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true })
  end,
}
