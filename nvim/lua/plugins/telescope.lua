return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'octarect/telescope-menu.nvim'
    },
    config = function()
      local function get_commands()
        require('telescope.builtin').commands({
          sort_mru = true
        })
      end

      local function get_buffer_fuzzy_find()
        require('telescope.builtin').current_buffer_fuzzy_find({})
      end

      local function get_lsp_document_symbols()
        require('telescope.builtin').lsp_document_symbols({})
      end

      local function get_lsp_workspace_symbols()
        require('telescope.builtin').lsp_workspace_symbols({})
      end

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
            case_mode = 'smart_case', -- or 'ignore_case', 'respect_case'
            fuzzy = true, -- false will only do exact matching
            override_file_sorter = true, -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
          },
          menu = {
            default = {
              items = {
                { display = "Commands", value = get_commands },
                { display = "Find", value = get_buffer_fuzzy_find },
                { display = "Symbols (Document)", value = get_lsp_document_symbols },
                { display = "Symbols (Workspace)", value = get_lsp_workspace_symbols },
              },
            },
          }
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

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('menu')

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

      local function get_menu()
        vim.cmd("Telescope menu")
      end

      -- NOTE: needs DESC
      vim.keymap.set("n", "<leader>a", get_menu)
      -- vim.keymap.set('n', '<leader>a', get_commands)
      vim.keymap.set('n', '<leader>b', get_buffers)
      vim.keymap.set('n', '<leader>e', get_old_files)
      vim.keymap.set('n', '<leader>f', get_find_files)
      vim.keymap.set('n', '<leader>g', get_git_files)
    end
  },
  {
    'gnikdroy/projections.nvim',
    enabled = true,
    branch = 'pre_release',
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    opts = {
      workspaces = {
        "~/dev/"
      },
      store_hooks = {
        pre = function()
          -- nvim-tree
          local nvim_tree_present, api = pcall(require, "nvim-tree.api")
          if nvim_tree_present then api.tree.close() end

          -- neo-tree
          if pcall(require, "neo-tree") then vim.cmd [[Neotree action=close]] end
        end
      }
    },
    config = function(_, opts)
      require('projections').setup(opts)

      local Session = require("projections.session")
      local Switcher = require("projections.switcher")
      local Telescope = require('telescope')
      local Workspace = require("projections.workspace")

      Telescope.load_extension('projections')
      vim.keymap.set("n", "<leader>p", function() vim.cmd("Telescope projections") end)

      -- Add workspace command
      vim.api.nvim_create_user_command("AddWorkspace", function()
        Workspace.add(vim.loop.cwd())
      end, {})

      -- Switch to project if vim was started in a project dir
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          if vim.fn.argc() == 0 then Switcher.switch(vim.loop.cwd()) end
        end,
      })

      -- Autostore session on VimExit
      vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
        callback = function() Session.store(vim.loop.cwd()) end,
      })

      -- Store session command
      vim.api.nvim_create_user_command("StoreProjectSession", function()
        Session.store(vim.loop.cwd())
      end, {})

      -- Restore session command
      vim.api.nvim_create_user_command("RestoreProjectSession", function()
        Session.restore(vim.loop.cwd())
      end, {})
    end
  },
}
