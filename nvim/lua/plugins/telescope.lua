return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    event = { "VeryLazy" },
    keys = {
      "<leader>a",
      "<leader>c",
      "<leader>e",
      "<leader>f",
      "<leader>l",
    },
    dependencies = {
      "catppuccin/nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "octarect/telescope-menu.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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

        parent = string.gsub(parent, vim.loop.cwd(), "")

        return string.format("%s\t\t%s", tail, parent)
      end

      local function refresh()
        vim.cmd("GitConflictRefresh")
        vim.cmd("GitConflictListQf")
      end

      telescope.setup({
        -- @see: https://github.com/nvim-telescope/telescope.nvim/issues/848#issuecomment-1584291014
        defaults = vim.tbl_extend(
          "force",
          themes.get_dropdown({
            borderchars = {
              { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
              prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
              results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
              preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            },
            layout_config = {
              width = function(_, max_columns, _)
                return math.min(max_columns, 100)
              end,
            },
          }),
          {
            file_ignore_patterns = {
              "%.git/.",
              -- "node_modules",
              -- "package-lock.json",
            },
            preview = false,
            path_display = formattedName,
            sorting_strategy = "ascending",
            mappings = {
              i = {
                ["<C-u>"] = false,
                ["<esc>"] = actions.close,
              },
            },
          }
        ),
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
                { display = "Commands", value = builtin.commands },
                {
                  display = "Copy file path (Absolute)",
                  value = function()
                    vim.cmd("CopyAbsolutePath")
                  end,
                },
                {
                  display = "Copy file path (Relative)",
                  value = function()
                    vim.cmd("CopyRelativePath")
                  end,
                },
                {
                  display = "Copy filetype",
                  value = function()
                    vim.cmd("CopyFiletype")
                  end,
                },
                { display = "Find", value = builtin.current_buffer_fuzzy_find },
                { display = "Format (Biome)", value = "FormatWithBiome" },
                { display = "Format (Prettier)", value = "FormatWithPrettier" },
                { display = "Format (default)", value = "Format" },
                { display = "Git (conflict)", value = refresh },
                { display = "Git (fugitive)", value = "Git" },
                { display = "Help", value = builtin.help_tags },
                { display = "Lint (Biome)", value = "LintWithBiome" },
                { display = "Lint (EsLint)", value = "LintWithPrettier" },
                { display = "Lint (default)", value = "Lint" },
                { display = "Noice dismiss", value = "Noice dismiss" },
                { display = "Noice messages", value = "Noice telescope" },
                { display = "Quit force", value = "qa!" },
                {
                  display = "Rename File",
                  value = "RenameFile",
                },
                { display = "Save", value = "wa" },
                { display = "Save and quit force", value = "wqa!" },
                { display = "Search", value = "Spectre" },
                {
                  display = "Symbols (Document)",
                  value = builtin.lsp_document_symbols,
                },
                {
                  display = "Symbols (Workspace)",
                  value = builtin.lsp_workspace_symbols,
                },
                { display = "Telescope", value = "Telescope" },
                { display = "Trouble", value = "Trouble" },
                { display = "Zen Mode", value = "NoNeckPain" },
                { display = "Zen Mode (decrease)", value = "NoNeckPainWidthDown" },
                { display = "Zen Mode (increase)", value = "NoNeckPainWidthUp" },
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

      telescope.load_extension("fzf")
      telescope.load_extension("menu")
      telescope.load_extension("ui-select")

      vim.keymap.set("n", "<leader>a", function()
        vim.cmd("Telescope menu")
      end)

      vim.keymap.set("n", "<leader>b", builtin.buffers)
      vim.keymap.set("n", "<leader>e", builtin.oldfiles)
      vim.keymap.set("n", "<leader>f", builtin.find_files)
      vim.keymap.set("n", "<leader>g", builtin.git_files)
      vim.keymap.set("n", "<leader>l", builtin.current_buffer_fuzzy_find)

      local colors = require("catppuccin.palettes").get_palette()

      local TelescopePrompt = {
        TelescopePromptNormal = {
          bg = colors.mantle,
        },
        TelescopePromptBorder = {
          fg = colors.mantle,
          bg = colors.mantle,
        },
        TelescopePromptTitle = {
          fg = colors.mantle,
          bg = colors.blue,
        },
        TelescopePreviewTitle = {
          fg = colors.mantle,
          bg = colors.mantle,
        },
        TelescopeResultsTitle = {
          fg = colors.mantle,
          bg = colors.mantle,
        },
        TelescopeResultsNormal = {
          bg = colors.mantle,
        },
        TelescopeResultsBorder = {
          fg = colors.mantle,
          bg = colors.mantle,
        },
      }

      for hl, col in pairs(TelescopePrompt) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end,
  },
}
