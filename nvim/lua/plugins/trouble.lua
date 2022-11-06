local M = {}

M.setup = function()
  require('trouble').setup({
    use_diagnostic_signs = true,
  })
end

return M
