return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    -- cmd = 'Telescope',
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_config = { prompt_position = 'top' },
          layout_strategy = 'horizontal',
          preview = false,
          prompt_prefix = " ",
          selection_caret = " ",
          sorting_strategy = "ascending",
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

      pcall(require('telescope').load_extension, 'fzf')

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
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    enabled = true,
    build = 'make',
    event = { 'VeryLazy' },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
