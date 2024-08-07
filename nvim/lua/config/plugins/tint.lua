local M = {}

M.setup = function()
  require("tint").setup({
    tint = -20,
    saturation = 0.8,
    highlight_ignore_patterns = {
      "LineNr",
      "StatusLine",
      "WinSeparator",
    },
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufid })
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufid })
      local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

      return filetype == "NvimTree" or buftype == "terminal" or floating
    end,
  })
end

return M
