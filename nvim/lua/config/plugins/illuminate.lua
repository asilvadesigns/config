local M = {}

M.setup = function()
  require("illuminate").configure({
    filetypes_denylist = { "grug-far", "NvimTree" },
    modes_allowlist = { "n" },
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true }),
    callback = function()
      vim.api.nvim_set_hl(0, "illuminatedWord", { underline = true })
      vim.api.nvim_set_hl(0, "illuminatedCurWord", { italic = true })
    end,
  })

  -- vim.api.nvim_set_hl(0, "illuminatedWord", {
  --   bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
  --   italic = false,
  --   underline = false,
  -- })
  --
  -- vim.api.nvim_set_hl(0, "illuminatedCurWord", {
  --   bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
  --   italic = false,
  --   underline = false,
  -- })
end

return M
