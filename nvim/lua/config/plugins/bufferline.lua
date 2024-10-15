local M = {}

M.setup = function()
  require("bufferline").setup({
    options = {
      mode = "buffers",
      always_show_bufferline = true,
      offsets = {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
    },
  })


end

return M
