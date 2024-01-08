return {
  "nvim-telescope/telescope.nvim",
  cmd = {
    "Telescope",
  },
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
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")
    local themes = require("telescope.themes")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "TelescopeResults",
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
          vim.fn.matchadd("TelescopeParent", "\t\t.*$")
          vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
      end,
    })

    local function formattedName(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then
        return tail
      end
      return string.format("%s\t\t%s", tail, parent)
    end

    telescope.setup({
      -- @see: https://github.com/nvim-telescope/telescope.nvim/issues/848#issuecomment-1584291014
      defaults = vim.tbl_extend("force", themes.get_dropdown(), {
        file_ignore_patterns = {
          "%.git/.",
          -- "node_modules",
          -- "package-lock.json",
        },
        preview = true,
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<esc>"] = actions.close,
          },
        },
      }),
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
              { display = "Commands", value = builtin.commands },
              { display = "Find", value = builtin.current_buffer_fuzzy_find },
              { display = "Format (Conform)", value = "Format" },
              { display = "Format (LSP)", value = "lua vim.lsp.buf.format()" },
              { display = "Help", value = builtin.help_tags },
              { display = "Projects", value = "Telescope projections" },
              { display = "Search", value = "Spectre" },
              {
                display = "Symbols (Document)",
                value = builtin.lsp_document_symbols,
              },
              {
                display = "Symbols (Workspace)",
                value = builtin.lsp_workspace_symbols,
              },
            },
          },
        },
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          only_cwd = true,
          path_display = formattedName,
          sort_mru = true,
        },
        colorscheme = {
          enable_preview = true,
        },
        commands = {
          sort_mru = true,
        },
        find_files = {
          hidden = true,
          path_display = formattedName,
        },
        git_files = {
          path_display = formattedName,
        },
        oldfiles = {
          only_cwd = true,
          path_display = formattedName,
          sort_mru = true,
        },
        help_tags = {},
      },
    })

    vim.keymap.set("n", "<leader>a", function()
      vim.cmd("Telescope menu")
    end)

    vim.keymap.set("n", "<leader>b", builtin.buffers)
    vim.keymap.set("n", "<leader>e", builtin.oldfiles)
    vim.keymap.set("n", "<leader>f", builtin.find_files)
    vim.keymap.set("n", "<leader>g", builtin.git_files)
    vim.keymap.set("n", "<leader>l", builtin.current_buffer_fuzzy_find)

    telescope.load_extension("menu")
    telescope.load_extension("ui-select")
  end,
}, {
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
}
