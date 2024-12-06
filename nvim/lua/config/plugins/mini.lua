local M = {}

_G.cursorword_blocklist = function()
  if vim.bo.filetype == "NvimTree" then
    vim.b.minicursorword_disable = true
  else
    vim.b.minicursorword_disable = false
  end
end

M.setup = function()
  vim.cmd("au CursorMoved * lua _G.cursorword_blocklist()")

  require("mini.cursorword").setup({
    delay = 25,
  })

  vim.api.nvim_set_hl(0, "MiniCursorword", {
    bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
    italic = false,
    underline = false,
  })

  vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {
    bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
    italic = false,
    underline = false,
  })
end

return M
