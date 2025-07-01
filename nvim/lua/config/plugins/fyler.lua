local M = {}

M.setup = function()
  require("fyler").setup({
    views = {
      explorer = {
        width = 0.8,
        height = 0.8,
        kind = "float",
        border = "rounded",
      },
    },
  })

  vim.keymap.set("n", "<leader>x", ":Fyler<CR>", { desc = "Show Fyler" })
end

return M
