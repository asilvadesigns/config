return {
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "VeryLazy" },
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "prisma",
        "python",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gsl",
          node_incremental = "gsi",
          node_decremental = "gsd",
          scope_incremental = "gss",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer" },
            ["if"] = { query = "@function.inner" },
            ["ac"] = { query = "@class.outer" },
            ["ic"] = { query = "@class.inner" },
            ["as"] = {
              query = "@scope",
              query_group = "locals",
              desc = "Select language scope",
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
