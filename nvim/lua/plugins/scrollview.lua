local M = {}

M.setup = function()
  require('scrollview').setup({
    excluded_filetypes = { 'NvimTree' },
    current_only = false,
    winblend = 75,
    base = 'buffer',
    column = 80,
  })
end

return M
