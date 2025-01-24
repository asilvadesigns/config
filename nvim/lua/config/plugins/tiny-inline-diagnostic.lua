local M = {}

M.setup = function()
  require("tiny-inline-diagnostic").setup({
    options = { show_source = true },
  })
  vim.diagnostic.config({ virtual_text = false })
end

return M
