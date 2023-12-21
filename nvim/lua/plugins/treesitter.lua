return {
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "andymass/vim-matchup",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "VeryLazy" },
    init = function()
      vim.g.matchup_matchparen_offscreen = {
        fullwidth = 1,
        highlight = "Normal",
        method = "popup",
        syntax_hl = 1,
      }
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
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
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        matchup = {
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
      })
    end,
  },
}
