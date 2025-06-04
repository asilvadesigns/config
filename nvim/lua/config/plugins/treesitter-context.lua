local M = {}

M.setup = function()
  require("treesitter-context").setup({
    enable = _G.treesitter_context_enabled,
    max_lines = 1,
    multiwindow = true,
  })

  vim.keymap.set("n", "]c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end, { silent = true })

  vim.api.nvim_create_user_command("ToggleTreesitterContext", function()
    _G.treesitter_context_enabled = not _G.treesitter_context_enabled
    require("treesitter-context").toggle()
  end, {})
end

return M
