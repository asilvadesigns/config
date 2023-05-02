return {
  {
    'windwp/nvim-autopairs',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'max397574/better-escape.nvim',
    enabled = true,
    event = { 'InsertEnter' },
    config = function()
      require('better_escape').setup({
        clear_empty_lines = false,  -- clear line after escaping if there is only whitespace
        keys = '<Esc>',             -- keys used for escaping, if it is a function will use the result everytime
        mapping = { 'kj' },         -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      })
    end,
  },
  {
    'ggandor/leap.nvim',
    event = { 'VeryLazy' },
    config = function()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      vim.api.nvim_set_hl(0, 'LeapMatch', {
        fg = 'white', -- set to black for light themes
        bold = true,
        nocombine = true,
      })

      -- require('leap').add_default_mappings()
      -- require('leap').setup()
      require('leap').opts.highlight_unlabeled_phase_one_targets = true

      vim.keymap.set('n', ';', "<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>")
    end,
  },
  {
    "folke/which-key.nvim",
    enabled = true,
    event = { 'VeryLazy' },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
}
