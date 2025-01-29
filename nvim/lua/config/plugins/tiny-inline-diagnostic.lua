_G.is_tiny_enabled = true

local M = {}

M.setup = function()
  require("tiny-inline-diagnostic").setup({
    options = {
      show_source = true,
    },
  })

  vim.diagnostic.config({ virtual_text = false })

  vim.api.nvim_create_user_command("ToggleDiagnosticTiny", function()
    if _G.is_tiny_enabled then
      require("tiny-inline-diagnostic").disable()
      vim.diagnostic.config({ virtual_text = true })
    else
      require("tiny-inline-diagnostic").enable()
      vim.diagnostic.config({ virtual_text = false })
    end

    _G.is_tiny_enabled = not _G.is_tiny_enabled
  end, {})
end

return M
