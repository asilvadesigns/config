local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })

  ---@diagnostic disable-next-line: missing-fields
  require("Comment").setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
