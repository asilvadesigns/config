return {
  {
    'tpope/vim-fugitive',
    enabled = true,
    lazy = false,
  },
  -- {
  --   'rhysd/conflict-marker.vim',
  --   enabled = true,
  --   lazy = false,
  -- },
  {
    'akinsho/git-conflict.nvim',
    enabled = true,
    lazy = false,
    config = function ()
      require('git-conflict').setup()
    end
  }
}
