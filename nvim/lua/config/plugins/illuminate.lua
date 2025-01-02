local M = {}

M.setup = function()
  require("illuminate").configure({
    filetypes_denylist = {
      "grug-far",
    },
    delay = 50,
  })

  vim.api.nvim_set_hl(0, "illuminatedWord", {
    bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
    italic = false,
    underline = false,
  })

  vim.api.nvim_set_hl(0, "illuminatedCurWord", {
    bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
    italic = false,
    underline = false,
  })
end

return M
