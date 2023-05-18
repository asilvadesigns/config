return {
  {
    'folke/zen-mode.nvim',
    enabled = true,
    event = { 'VeryLazy' },
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    enabled = true,
    event = { 'InsertEnter' },
    opts = {},
  },
  {
    "gbprod/substitute.nvim",
    enabled = true,
    event = { 'CursorMoved' },
    config = function()
      require('substitute').setup()

      vim.keymap.set("x", "X", require('substitute.exchange').visual, { noremap = true })
    end
  },
  {
    'kylechui/nvim-surround',
    enabled = true,
    event = { 'CursorMoved' },
    keys = {
      {
        'ds',
        'cs',
      }
    },
    opts = {},
  },
  {
    'max397574/better-escape.nvim',
    enabled = true,
    event = { 'InsertEnter' },
    config = function()
      require('better_escape').setup({
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = '<Esc>', -- keys used for escaping, if it is a function will use the result everytime
        mapping = { 'kj' }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      })
    end,
  },
  {
    'ggandor/leap.nvim',
    keys = {
      {
        ';',
        '<CMD>lua require("leap").leap({ target_windows = { vim.fn.win_getid() } })<CR>'
      }
    },
    config = function()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey

      vim.api.nvim_set_hl(0, 'LeapMatch', {
        -- For light themes, set to 'black' or similar.
        fg = 'white',
        bold = true,
        nocombine = true,
      })

      -- Of course, specify some nicer shades instead of the default "red" and "blue".
      vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
        fg = 'red', bold = true, nocombine = true,
      })

      vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
        fg = 'blue', bold = true, nocombine = true,
      })

      -- require('leap').opts.highlight_unlabeled_phase_one_targets = false

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
