-- @see: https://github.com/nathom/filetype.nvim/issues/68
local function bash_literal()
  vim.bo.filetype = 'sh'
  vim.b.is_bash = true
end

local M = {}

M.setup = function()
  require('filetype').setup({
    overrides = {
      complex = {
        ['.*/.bash.*'] = bash_literal,
      },
    },
  })
end

return M
