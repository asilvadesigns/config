---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("flash").setup({})

  vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
  end, { desc = "Flash" })

  -- NOTE: conflicts with my usage of S.
  -- vim.keymap.set({ "n", "x", "o" }, "S", function()
  --   require("flash").treesitter()
  -- end, { desc = "Flash Treesitter" })

  -- NOTE: I don't use this
  -- vim.keymap.set("o", "r", function()
  --   require("flash").remote()
  -- end, { desc = "Remote Flash" })
  --
  -- NOTE: ...or this
  -- vim.keymap.set({ "o", "x" }, "R", function()
  --   require("flash").treesitter_search()
  -- end, { desc = "Treesitter Search" })

  vim.keymap.set("c", "<C-s>", function()
    require("flash").toggle()
  end, { desc = "Toggle Flash Search" })
end

return M
