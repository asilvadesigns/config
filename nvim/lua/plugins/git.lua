return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
    opts = {
      signcolumn = false,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Gdiffsplit",
      "Git",
      "Gvdiffsplit",
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewClose",
      "DiffviewFocusFiles",
      "DiffviewOpen",
      "DiffviewToggleFiles",
    },
    opts = {},
  },
  {
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictListQf",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
    },
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_commands = true,
        default_mappings = false,
        disable_diagnostics = true,
        list_opener = "copen", -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          current = "DiffText",
          incoming = "DiffAdd",
        },
      })

      -- TODO revisit.
      -- vim.keymap.set('n', '[x', '<CMD>GitConflictNextConflict<CR>')
      -- vim.keymap.set('n', ']x', '<CMD>GitConflictPrevConflict<CR>')
      -- vim.keymap.set('n', 'c0', '<CMD>GitConflictChooseNone<CR>')
      -- vim.keymap.set('n', 'cb', '<CMD>GitConflictChooseBoth<CR>')
      -- vim.keymap.set('n', 'cf', '<CMD>GitConflictListQf<CR>')
      -- vim.keymap.set('n', 'co', '<CMD>GitConflictChooseOurs<CR>')
      -- vim.keymap.set('n', 'ct', '<CMD>GitConflictChooseTheirs<CR>')
    end,
  },
}
