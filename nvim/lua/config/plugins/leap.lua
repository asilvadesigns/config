local M = {}

M.setup = function()
  require("leap").opts.safe_labels = {}
  require("leap").opts.highlight_unlabeled_phase_one_targets = true
  vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "NonText" }) -- darken everything
  vim.api.nvim_set_hl(0, "LeapLabel", { link = "DiagnosticVirtualTextError" }) -- darken everything
end

return M
