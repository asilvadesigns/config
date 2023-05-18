return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = true,
    event = { 'VeryLazy' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
      ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'gitignore',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'prisma',
        'python',
        'scss',
        'tsx',
        'typescript',
        'vim',
        'yaml',
      },
      highlight = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
      -- matchup = {
      --   enable = true,
      -- },
    },
    config = function (_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    'windwp/nvim-ts-autotag',
    enabled = true,
    event = { 'VeryLazy' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  -- {
  --   'andymass/vim-matchup',
  --   enabled = true,
  --   name = 'matchup',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --   }
  -- },
  -- NOTE: this isnt very useful atm
  -- {
  --   'nvim-treesitter/playground',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter-context',
  --   },
  --   config = function()
  --     require('treesitter-context').setup({
  --       max_lines = 1
  --     })
  --   end,
  -- },
  {
    'numToStr/Comment.nvim',
    enabled = true,
    event = { 'VeryLazy' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
}
