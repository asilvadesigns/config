local M = {}

M.setup = function()
  local options = require("config.options")

  require("scrollview").setup({
    column = 1,
    current_only = false,
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

  local square = vim.fn.nr2char(0x25aa)

  vim.g.scrollview_diagnostics_error_symbol = options.signs.Error
  vim.g.scrollview_diagnostics_hint_symbol = options.signs.Hint
  vim.g.scrollview_diagnostics_info_symbol = options.signs.Info
  vim.g.scrollview_diagnostics_warn_symbol = options.signs.Warn
  -- vim.g.scrollview_diagnostics_error_symbol = square
  -- vim.g.scrollview_diagnostics_hint_symbol = square
  -- vim.g.scrollview_diagnostics_info_symbol = square
  -- vim.g.scrollview_diagnostics_warn_symbol = square
  vim.g.scrollview_cursor_symbol = square
end

return M
