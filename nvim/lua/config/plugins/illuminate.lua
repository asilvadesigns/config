local M = {}

M.setup = function()
  require("illuminate").configure({
    filetypes_denylist = {
      "NvimTree",
      "fugitiveblame",
      "fyler",
      "grug-far",
      "markdown",
    },
    modes_allowlist = { "n" },
    delay = 50,
    min_count_to_highlight = 2,
  })

  -- vim.api.nvim_create_autocmd("VimEnter", {
  --   group = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true }),
  --   callback = function()
  --     vim.api.nvim_set_hl(0, "illuminatedWord", { underline = true })
  --     vim.api.nvim_set_hl(0, "illuminatedCurWord", { italic = true })
  --   end,
  -- })
end

return M
