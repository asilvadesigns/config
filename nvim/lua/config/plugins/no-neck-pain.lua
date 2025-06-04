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
    _G.zen_mode_enabled = not _G.zen_mode_enabled
    require("no-neck-pain").toggle()
  end, {})

  -- vim.keymap.set("n", "<leader>z", function()
  --   vim.cmd("ToggleZenMode")
  -- end, { desc = "Toggle Zen Mode" })
end

return M
