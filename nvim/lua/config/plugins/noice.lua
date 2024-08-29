local M = {}

M.setup = function()
  require("noice").setup({
    cmdline = {
      enabled = true,
      format = {
        cmdline = {
          icon = " ",
          lang = "vim",
          pattern = "^:",
          view = "cmdline",
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
      signature = {
        auto_open = {
          trigger = false,
        },
      },
    },
    presets = {
      bottom_search = true,
    },
    routes = {
      {
        -- skip "-- insert --"
        view = "notify",
        filter = { event = "msg_showmode" },
        opts = { skip = true },
      },
      {
        -- skip "No information available"
        view = "notify",
        filter = { event = "msg_show", find = "No information available" },
        opts = { skip = true },
      },
      {
        -- skip "written"
        view = "notify",
        filter = { event = "msg_show", find = "written" },
        opts = { skip = true },
      },
    },
  })

  vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true })
end

return M
