return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTelescope", "TodoLocList" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- TODO: yo forreal tho.
    require("todo-comments").setup({
      signs = false,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        HACK = { icon = " ", color = "warning" },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        TEST = { icon = " ⏲", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        TODO = { icon = " 󰄬", color = "info" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      },
      highlight = {
        before = "",
        keyword = "",
        after = "",
        multiline = false, -- enable multine todo comments
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
      },
    })

    require("todo-comments").enable()

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
  end,
}
