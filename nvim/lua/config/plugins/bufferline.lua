local M = {}

M.setup = function()
  require("bufferline").setup({
    options = {
      mode = "tabs", --tabs or buffers
      -- always_show_bufferline = true,
      -- -- numbers = function(opts)
      -- --   return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
      -- -- end,
      -- offsets = {
      --   filetype = "NvimTree",
      --   text = "File Explorer",
      --   highlight = "Directory",
      --   separator = true, -- use a "true" to enable the default, or set your own character
      -- },
      -- indicator = {
      --   icon = "",
      --   style = "none",
      -- },
      -- separator_style = "none",
      -- show_buffer_close_icons = false,
      -- show_buffer_icons = false,
      -- show_close_icon = false,
      -- show_tab_indicators = false,
    },
  })
end

return M
