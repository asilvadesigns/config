local M = {}

local square = vim.fn.nr2char(0x25aa)

M.icons = {
  square = square,
}

M.diagnostics = {
  Error = square,
  Warn = square,
  Hint = square,
  Info = square,
}

return M
