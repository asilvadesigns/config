return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    event = "VeryLazy" ,
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      vim.treesitter.language.register("mdx", { "markdown" })

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "gitignore",
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
          "scss",
          "templ",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        highlight = {
          additional_vim_regex_highlighting = false,
          enable = true,
        },
        indent = {
          enable = false,
        },
        incremental_selection = {
          enable = false,
          -- NOTE: conflicts with leap.
          keymaps = {
            init_selection = "gsl",
            node_decremental = "gsd",
            node_incremental = "gsi",
            scope_incremental = "gss",
          },
        },
        textobjects = {
          move = {
            enable = true,
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
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>tj", mode = "n", ":TSJJoin<CR>", silent = true },
      { "<leader>tm", mode = "n", ":TSJToggle<CR>", silent = true },
      { "<leader>ts", mode = "n", ":TSJSplit<CR>", silent = true },
    },
    opts = {},
  },
}
