local M = {}

M.setup = function()
  local plugin = require("gitsigns")

  plugin.setup({
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
    signcolumn = _G.show_gitsigns, -- Toggle with `:Gitsigns toggle_signs`
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

  local enable = function()
    _G.show_gitsigns = true
    plugin.toggle_signs(_G.show_gitsigns)
  end

  local toggle = function()
    _G.show_gitsigns = not _G.show_gitsigns
    plugin.toggle_signs(_G.show_gitsigns)
  end

  vim.keymap.set("n", "[g", function()
    enable()
    plugin.nav_hunk("prev")
  end, { desc = "Go to prev chunk" })

  vim.keymap.set("n", "]g", function()
    enable()
    plugin.nav_hunk("next")
  end, { desc = "Go to next chunk" })

  vim.keymap.set("n", "gl", function()
    enable()
    plugin.blame_line()
  end, { desc = "toggle git line blame" })

  vim.api.nvim_create_user_command("ToggleGitBlame", function()
    _G.show_gitblame = not _G.show_gitblame
  end, {})

  vim.api.nvim_create_user_command("ToggleGitSigns", function()
    toggle()
  end, {})
end

return M
