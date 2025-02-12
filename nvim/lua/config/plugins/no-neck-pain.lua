local M = {}

M.setup = function()
  require("no-neck-pain").setup({
    buffers = {
      scratchPad = {
        enabled = false,
      },
    },
  })
end

return M
