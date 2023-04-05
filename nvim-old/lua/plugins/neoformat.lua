local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>m', ':Neoformat<CR>')
end

return M
