local M = {}

M.setup = function()
  local plugin = require("no-neck-pain")

  plugin.setup({
    buffers = {
      scratchPad = {
        enabled = false,
      },
    },
    width = 120,
  })

  vim.api.nvim_create_user_command("ZenMode80", function()
    _G.enable_zen_mode = true
    plugin.enable()
    plugin.resize(80)
  end, {})

  vim.api.nvim_create_user_command("ZenMode100", function()
    _G.enable_zen_mode = true
    plugin.enable()
    plugin.resize(100)
  end, {})

  vim.api.nvim_create_user_command("ZenMode120", function()
    _G.enable_zen_mode = true
    plugin.enable()
    plugin.resize(120)
  end, {})

  vim.api.nvim_create_user_command("ToggleZenMode", function()
    _G.enable_zen_mode = not _G.enable_zen_mode

    -- if _G.enable_zen_mode then
    --   require("nvim-tree.api").tree.close()
    -- end

    plugin.toggle()
    vim.api.nvim_exec_autocmds("User", { pattern = "RefreshWinbar" })
  end, {})
end

return M
