local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("noice").setup({
    cmdline = {
      enabled = true,
      view = "cmdline",
      format = {
        cmdline = { icon = " ", lang = "vim", pattern = "^:", view = "cmdline" },
        search_down = { icon = "  ", kind = "search", lang = "regex", pattern = "^/" },
        search_up = { icon = "  ", kind = "search", lang = "regex", pattern = "^%?" },
        -- input = false, -- { view = "cmdline_popup" },
        help = false,
        lua = false,
      },
    },
    messages = { enabled = true },
    notify = { enabled = false },
    popupmenu = { enabled = false },
    lsp = {
      override = {
        ["cmp.entry.get_documentation"] = true,
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      progress = { enabled = false },
      signature = { auto_open = { trigger = false } },
    },
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  })
end

return M
