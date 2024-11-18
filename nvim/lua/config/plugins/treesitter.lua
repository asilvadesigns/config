local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup({
    auto_install = false,
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
      "regex",
      "scss",
      "templ",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    matchup = {
      enabled = false,
      include_match_words = false,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "tmux" },
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
    -- textobjects = {
    --   move = {
    --     enable = true,
    --     set_jumps = true,
    --     goto_previous_start = {
    --       ["[f"] = { query = "@function.outer", desc = "Previous function" },
    --       ["[c"] = { query = "@class.outer", desc = "Previous class" },
    --       ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
    --     },
    --     goto_next_start = {
    --       ["]f"] = { query = "@function.outer", desc = "Next function" },
    --       ["]c"] = { query = "@class.outer", desc = "Next class" },
    --       ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
    --     },
    --   },
    --   select = {
    --     enable = true,
    --     lookahead = true,
    --     include_surrounding_whitespace = false,
    --     keymaps = {
    --       ["af"] = { query = "@function.outer" },
    --       ["if"] = { query = "@function.inner" },
    --       ["ac"] = { query = "@class.outer" },
    --       ["ic"] = { query = "@class.inner" },
    --       ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
    --       ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
    --       ["al"] = { query = "@loop.outer", desc = "around a loop" },
    --       ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
    --       ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
    --       ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
    --       ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
    --     },
    --   },
    -- },
  })

  -- require("treesitter-context").setup({
  --   enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
  --   max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
  --   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  --   line_numbers = true,
  --   multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  --   trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  --   mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  --   -- Separator between context and content. Should be a single character string, like '-'.
  --   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  --   separator = nil,
  --   zindex = 20, -- The Z-index of the context window
  --   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  -- })
  -- require("treesitter-context").enable()

  -- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
  -- ft_to_parser.mdx = "markdown"

  vim.treesitter.language.register("markdown", "mdx")
  vim.treesitter.language.register("templ", "templ")
  vim.cmd("TSEnable all highlight")
end

return M
