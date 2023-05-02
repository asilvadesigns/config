return {
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))

      require('nvim-treesitter.configs').setup({
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
        -- JoosepAlviste/nvim-ts-context-commentstring
        context_commentstring = {
          enable = true,
        },
        -- andymass/vim-matchup
        matchup = {
          enable = true,
        },
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'andymass/vim-matchup',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
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
    event = { 'BufReadPost', 'BufNewFile' },
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
