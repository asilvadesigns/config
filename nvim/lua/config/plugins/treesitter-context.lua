local M = {}

M.setup = function()
  require("treesitter-context").setup({
    enable = _G.show_treesitter_context,
    max_lines = 1,
    multiwindow = true,
  })

  vim.keymap.set("n", "]c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end, { silent = true })

  vim.api.nvim_create_user_command("ToggleTreesitterContext", function()
    _G.show_treesitter_context = not _G.show_treesitter_context
    require("treesitter-context").toggle()
  end, {})
end

return M
