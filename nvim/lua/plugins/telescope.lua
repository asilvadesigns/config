return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_config = { prompt_position = 'top' },
          layout_strategy = 'horizontal',
          preview = false,
          winblend = 0,
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<esc>'] = require('telescope.actions').close,
            },
          },
        },
        extensions = {
          fzf = {
            case_mode = 'smart_case',       -- or 'ignore_case', 'respect_case'
            fuzzy = true,                   -- false will only do exact matching
            override_file_sorter = true,    -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          oldfiles = {
            only_cwd = true,
          },
        },
      })

      pcall(require('telescope').load_extension, 'file_browser')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'persisted')

      local function get_commands()
        require('telescope.builtin').commands()
      end

      local function get_buffers()
        require('telescope.builtin').buffers({
          ignore_current_buffer = true,
          only_cwd = true,
          sort_mru = true
        })
      end

      local function get_old_files()
        require('telescope.builtin').oldfiles({
          only_cwd = true,
        })
      end

      local function get_find_files()
        require('telescope.builtin').find_files()
      end

      local function get_git_files()
        require('telescope.builtin').git_files()
      end

      -- NOTE: needs DESC
      vim.keymap.set('n', '<leader>a', get_commands)
      vim.keymap.set('n', '<leader>b', get_buffers)
      vim.keymap.set('n', '<leader>e', get_old_files)
      vim.keymap.set('n', '<leader>f', get_find_files)
      vim.keymap.set('n', '<leader>g', get_git_files)

      vim.api.nvim_set_keymap(
      'n',
      '<leader>x',
      ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
      { noremap = true }
      )
    end
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
}
