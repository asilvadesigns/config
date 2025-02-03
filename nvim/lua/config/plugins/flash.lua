---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("flash").setup({
    modes = {
      char = {
        enabled = false,
      },
    },
  })

  vim.cmd("hi! link FlashLabel DiagnosticVirtualTextError")
  vim.cmd("hi! link FlashMatch DiagnosticVirtualTextWarn")
  vim.cmd("hi! link FlashCurrent DiagnosticVirtualTextInfo")

  vim.keymap.set("n", "s", function()
    require("flash").jump()
  end, { desc = "Flash" })

  vim.keymap.set("o", "r", function()
    require("flash").remote()
  end, { desc = "Remote Flash" })

  -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
end

return M
