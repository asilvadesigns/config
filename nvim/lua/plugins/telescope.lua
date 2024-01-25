return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = {
      "<leader>a",
      "<leader>e",
      "<leader>f",
      "<leader>l",
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "octarect/telescope-menu.nvim" },
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
          preview = false,
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
            case_mode = "smart_case",
            fuzzy = true,
            override_file_sorter = true,
            override_generic_sorter = true,
          },
          menu = {
            default = {
              items = {
                { display = "Commands",          value = builtin.commands },
                { display = "Find",              value = builtin.current_buffer_fuzzy_find },
                { display = "Format (Biome)",    value = "FormatWithBiome" },
                { display = "Format (Prettier)", value = "FormatWithPrettier" },
                { display = "Format (lsp)",      value = "Format" },
                { display = "Help",              value = builtin.help_tags },
                { display = "Projects",          value = "Telescope neovim-project discover" },
                { display = "Search",            value = "Spectre" },
                {
                  display = "Symbols (Document)",
                  value = builtin.lsp_document_symbols,
                },
                {
                  display = "Symbols (Workspace)",
                  value = builtin.lsp_workspace_symbols,
                },
                {
                  display = "Telescope",
                  value = "Telescope",
                },
              },
            },
            -- format = {
            --   items = {
            --     { display = "Format (with Biome)",    value = "FormatWithBiome" },
            --     { display = "Format (with LSP)",                 value = "Format" },
            --     { display = "Format (with Prettier)", value = "FormatWithPrettier" },
            --   },
            -- },
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

      telescope.load_extension("frecency")
      telescope.load_extension("fzf")
      telescope.load_extension("menu")
      telescope.load_extension("ui-select")

      vim.keymap.set("n", "<leader>a", function()
        vim.cmd("Telescope menu")
      end)

      -- prevoiusly used "builtin.buffers"
      local oldfiles = function()
        vim.cmd("Telescope frecency")
      end

      vim.keymap.set("n", "<leader>b", builtin.buffers)
      vim.keymap.set("n", "<leader>e", oldfiles)
      vim.keymap.set("n", "<leader>f", builtin.find_files)
      vim.keymap.set("n", "<leader>g", builtin.git_files)
      vim.keymap.set("n", "<leader>l", builtin.current_buffer_fuzzy_find)
    end,
  },
  {
    "coffebar/neovim-project",
    dependencies = {
      { "Shatur/neovim-session-manager" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      vim.opt.sessionoptions:append("globals")

      require("neovim-project").setup({
        last_session_on_startup = false,
        projects = {
          "~/.config",
          "~/dev/*",
        },
      })

      vim.keymap.set("n", "<leader>p", function()
        vim.cmd("Telescope neovim-project discover")
      end)
    end,
    lazy = false,
    priority = 100,
  },
}
