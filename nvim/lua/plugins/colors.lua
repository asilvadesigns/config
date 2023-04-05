local M = {}

M.setup = function()
  -- THEME::ONEDARK
  require('onedark').setup({ style = 'dark' })
  require('onedark').load()

  -- THEME::EDGE
  -- vim.cmd('colorscheme edge')

  -- RESETS
  -- enable fold lines like comments
  vim.cmd('highlight! clear FoldColumn')

  -- setup  for nvim-tree, bug doesn't work in nvim-tree.lua
  vim.cmd('highlight! clear NvimTreeEndOfBuffer')
  vim.cmd('highlight! clear NvimTreeNormal')
  vim.cmd('highlight! clear NvimTreeVertSplit')
  vim.cmd('highlight! link NvimTreeIndentMarker Comment')

  -- vim.cmd('highlight! link ScrollView CursorLine')
end

return M
