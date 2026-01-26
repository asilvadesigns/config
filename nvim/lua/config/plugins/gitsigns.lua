local M = {}

M.setup = function()
  require("gitsigns").setup({
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = _G.show_gitsigns,  -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,
    current_line_blame_opts = {
      ignore_whitespace = true,
      delay = 200, --default 1000
    },
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
end

vim.keymap.set("n", "gl", function()
  require("gitsigns").blame_line()
end, { desc = "toggle git line blame" })


vim.api.nvim_create_user_command("ToggleGitBlame", function()
  _G.show_gitblame = not _G.show_gitblame
end, {})

vim.api.nvim_create_user_command("ToggleGitSigns", function()
  _G.show_gitsigns = not _G.show_gitsigns
  vim.cmd("Gitsigns toggle_signs")
end, {})

return M
