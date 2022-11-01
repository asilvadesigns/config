local M = {}

M.setup = function()
  require('onedark').setup({ style = 'dark' })
  require('onedark').load()
end

return M
