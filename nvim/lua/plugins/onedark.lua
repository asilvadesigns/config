local M = {}

M.setup = function()
  require('onedark').setup({ style = 'dark' })
  require('onedark').load()

  -- enable fold lines like comments
  vim.cmd('highlight! clear FoldColumn')
end

return M
