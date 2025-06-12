local M = {}

M.setup = function()
  require("no-neck-pain").setup({
    buffers = {
      scratchPad = {
        enabled = false,
      },
    },
    width = 120,
  })

  vim.api.nvim_create_user_command("ToggleZenMode", function()
    _G.enable_zen_mode = not _G.enable_zen_mode
    require("no-neck-pain").toggle()
  end, {})

  -- vim.keymap.set("n", "<leader>z", function()
  --   vim.cmd("ToggleZenMode")
  -- end, { desc = "Toggle Zen Mode" })
end

return M
