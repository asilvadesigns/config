local M = {}

M.setup = function()
  require("no-neck-pain").setup({
    buffers = {
      scratchPad = {
        enabled = false,
      },
    },
    width = 120,
  })
end

return M
