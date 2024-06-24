local M = {}

M.setup = function()
  local options = require("config.options")

  require("scrollview").setup({
    always_show = false,
    column = 1,
    current_only = true,
    cursor_symbol = vim.fn.nr2char(0x25aa),
    winblend_gui = 50,
    excluded_filetypes = {
      "NvimTree",
      "Outline",
      "TelescopePrompt",
      "Trouble",
      "alpha",
      "dashboard",
      "help",
      "lir",
      "neogitstatus",
      "no-neck-pain",
      "packer",
      "qf",
      "spectre_panel",
      "startify",
      "telescope",
      "toggleterm",
    },
    signs_on_startup = {
      -- "conflicts",
      "cursor",
      "diagnostics",
      -- "folds",
      -- "loclist",
      -- "marks",
      "quickfix",
      "search",
      -- "spell",
      -- "textwidth",
      -- "trail",
    },
  })

  vim.g.scrollview_diagnostics_error_symbol = options.signs.Error
  vim.g.scrollview_diagnostics_hint_symbol = options.signs.Hint
  vim.g.scrollview_diagnostics_info_symbol = options.signs.Info
  vim.g.scrollview_diagnostics_warn_symbol = options.signs.Warn

  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
      vim.cmd("ScrollViewRefresh")
    end,
  })
end

return M
