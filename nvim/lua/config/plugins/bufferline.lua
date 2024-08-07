local M = {}

M.setup = function()
  require("bufferline").setup({
    options = {
      mode = "tabs",
      always_show_bufferline = false,
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
