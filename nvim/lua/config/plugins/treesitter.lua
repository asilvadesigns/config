local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup({
    sync_install = false,
    reattach_after_install = {
      enable = true,
    },
    ensure_installed = {
      "bash",
      "css",
      "dockerfile",
      "gitignore",
      "gleam",
      "go",
      "gomod",
      "gosum",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "prisma",
      "python",
      "regex",
      "scss",
      "templ",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    highlight = {
      -- enable = not _G.enable_simple_colors,
      enable = true,
    },
    indent = {
      enable = false,
    },
    textobjects = {
      move = {
        enable = false,
        set_jumps = true,
        goto_previous_start = {
          ["[f"] = { query = "@function.outer", desc = "Previous function" },
          ["[c"] = { query = "@class.outer", desc = "Previous class" },
          ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
        },
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function" },
          ["]c"] = { query = "@class.outer", desc = "Next class" },
          ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
        },
      },
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = false,
        keymaps = {
          ["af"] = { query = "@function.outer" },
          ["if"] = { query = "@function.inner" },
          ["ac"] = { query = "@class.outer" },
          ["ic"] = { query = "@class.inner" },
          ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
          ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
          ["al"] = { query = "@loop.outer", desc = "around a loop" },
          ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
          ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
          ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
      },
    },
  })

  vim.treesitter.language.register("markdown", "mdx")
  vim.treesitter.language.register("templ", "templ")

  vim.schedule(function()
    vim.api.nvim_exec_autocmds("User", { pattern = "TreesitterReady" })
  end)
end

return M
