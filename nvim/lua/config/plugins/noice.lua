local M = {}

M.setup = function()
  require("noice").setup({
    cmdline = {
      enabled = true,
      view = "cmdline",
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
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = { enabled = true },
      signature = {
        auto_open = {
          trigger = false,
        },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = false, -- position the cmdline and popupmenu together
      -- long_message_to_split = true, -- long messages will be sent to a split
      -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
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

  local nt_api = require("nvim-tree.api")
  nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
    local tree_winid = nt_api.tree.winid()

    if tree_winid ~= nil then
      vim.api.nvim_set_option_value("statusline", "", { win = tree_winid })
    end
  end)

  vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true })
end

return M
