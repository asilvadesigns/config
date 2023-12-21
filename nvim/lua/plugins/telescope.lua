return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      "<leader>a",
      "<leader>e",
      "<leader>f",
      "<leader>l",
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "octarect/telescope-menu.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      local function get_commands()
        require("telescope.builtin").commands({ sort_mru = true })
      end

      local function get_buffer_fuzzy_find()
        require("telescope.builtin").current_buffer_fuzzy_find({})
      end

      local function get_lsp_document_symbols()
        require("telescope.builtin").lsp_document_symbols({})
      end

      local function get_help()
        require("telescope.builtin").help_tags({})
      end

      local function get_projects()
        vim.cmd("Telescope projections")
      end

      local function get_lsp_workspace_symbols()
        require("telescope.builtin").lsp_workspace_symbols({})
      end

      local function get_search()
        vim.cmd("Spectre")
      end

      require("telescope").setup({
        defaults = {
          layout_config = { prompt_position = "top" },
          layout_strategy = "horizontal",
          preview = true,
          prompt_prefix = " ",
          selection_caret = " ",
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
        extensions = {
          fzf = {
            case_mode = "smart_case", -- or 'ignore_case', 'respect_case'
            fuzzy = true, -- false will only do exact matching
            override_file_sorter = true, -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
          },
          menu = {
            default = {
              items = {
                { display = "Commands", value = get_commands },
                { display = "Find", value = get_buffer_fuzzy_find },
                { display = "Help", value = get_help },
                { display = "Projects", value = get_projects },
                { display = "Search", value = get_search },
                {
                  display = "Symbols (Document)",
                  value = get_lsp_document_symbols,
                },
                {
                  display = "Symbols (Workspace)",
                  value = get_lsp_workspace_symbols,
                },
              },
            },
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

      require("telescope").load_extension("menu")
      require("telescope").load_extension("ui-select")

      local function get_buffers()
        require("telescope.builtin").buffers({
          ignore_current_buffer = true,
          only_cwd = true,
          sort_mru = true,
        })
      end

      local function get_old_files()
        require("telescope.builtin").oldfiles({
          only_cwd = true,
        })
      end

      local function get_find_files()
        require("telescope.builtin").find_files()
      end

      local function get_git_files()
        require("telescope.builtin").git_files()
      end

      local function get_menu()
        vim.cmd("Telescope menu")
      end

      -- NOTE: needs DESC
      vim.keymap.set("n", "<leader>a", get_menu)
      -- vim.keymap.set('n', '<leader>a', get_commands)
      vim.keymap.set("n", "<leader>b", get_buffers)
      vim.keymap.set("n", "<leader>e", get_old_files)
      vim.keymap.set("n", "<leader>f", get_find_files)
      vim.keymap.set("n", "<leader>g", get_git_files)
      vim.keymap.set("n", "<leader>l", get_buffer_fuzzy_find)
    end,
  },
  {
    "gnikdroy/projections.nvim",
    branch = "pre_release",
    event = { "VeryLazy" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("projections").setup({
        workspaces = {
          "~/.config",
          "~/dev/",
        },
        workspaces_file = "~/.config/nvim/workspaces.json",
        store_hooks = {
          pre = function()
            -- nvim-tree
            local nvim_tree_present, api = pcall(require, "nvim-tree.api")
            if nvim_tree_present then
              api.tree.close()
            end

            -- neo-tree
            if pcall(require, "neo-tree") then
              vim.cmd([[Neotree action=close]])
            end
          end,
        },
      })

      local session = require("projections.session")
      local switcher = require("projections.switcher")
      local telescope = require("telescope")
      local workspace = require("projections.workspace")

      telescope.load_extension("projections")
      vim.keymap.set("n", "<leader>p", function()
        vim.cmd("Telescope projections")
      end)

      -- Add workspace command
      vim.api.nvim_create_user_command("AddWorkspace", function()
        workspace.add(vim.loop.cwd())
      end, {})

      -- Switch to project if vim was started in a project dir
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          if vim.fn.argc() == 0 then
            switcher.switch(vim.loop.cwd())
          end
        end,
      })

      -- Autostore session on VimExit
      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        callback = function()
          session.store(vim.loop.cwd())
        end,
      })

      -- Store session command
      vim.api.nvim_create_user_command("StoreProjectSession", function()
        session.store(vim.loop.cwd())
      end, {})

      -- Restore session command
      vim.api.nvim_create_user_command("RestoreProjectSession", function()
        session.restore(vim.loop.cwd())
      end, {})
    end,
  },
}
