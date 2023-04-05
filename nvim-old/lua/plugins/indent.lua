local M = {}

M.setup = function()
  vim.opt.list = true
  -- vim.opt.listchars:append('eol:↴')

  require('indent_blankline').setup({
    show_end_of_line = false,
  })

  vim.cmd('highlight! link IndentBlanklineChar VertSplit')
end

return M
