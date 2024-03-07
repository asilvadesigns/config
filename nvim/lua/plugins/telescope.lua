return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
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
      local conf = require("telescope.config").values
      local finders = require("telescope.finders")
      local pickers = require("telescope.pickers")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local command_palette = function(opts)
        opts = opts or {}
        pickers
          .new(opts, {
            prompt_title = "colors",
            finder = finders.new_table({
              results = {
                { "red", function() print("chosen Red!!") end },
                { "green", function() print("got green") end },
                { "blue", function() print("selected blue!") end },
              },
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = function()
                    -- TODO: for certain toggle functions, I'd like to display some switches.
                    -- some custom logic here...
                    return entry[1]
                  end,
                  ordinal = entry[1],
                }
              end,
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                selection.value[2]()
                -- vim.api.nvim_put({ selection[1] }, "", false, true)
              end)
              return true
            end,
          })
          :find()
      end

      --
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
              height = function(_, _, max_lines)
                return math.min(max_lines, 40)
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
                {
                  display = "Command Palette",
                  value = function()
                    command_palette()
                  end,
                },
                { display = "Save and quit force", value = "wqa!" },
                { display = "Search", value = "Spectre" },
                { display = "Symbols", value = "Outline" },
                {
                  display = "Symbols (Document)",
                  value = builtin.lsp_document_symbols,
                },
                {
                  display = "Symbols (Workspace)",
                  value = builtin.lsp_workspace_symbols,
                },
                { display = "Telescope", value = "Telescope" },
                { display = "Toggle Invisible Chars (global)", value = "set list!" },
                { display = "Toggle Invisible Chars (local)", value = "setlocal list!" },
                { display = "Toggle Line Numbers (global)", value = "set rnu! nu!" },
                { display = "Toggle Line Numbers (local)", value = "setlocal rnu! nu!" },
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
          bg = colors.surface0,
        },
        TelescopePromptBorder = {
          fg = colors.surface0,
          bg = colors.surface0,
        },
        TelescopePromptTitle = {
          fg = colors.surface0,
          bg = colors.blue,
        },
        TelescopePreviewTitle = {
          fg = colors.surface0,
          bg = colors.surface0,
        },
        TelescopeResultsTitle = {
          fg = colors.surface0,
          bg = colors.surface0,
        },
        TelescopeResultsNormal = {
          bg = colors.surface0,
        },
        TelescopeResultsBorder = {
          fg = colors.surface0,
          bg = colors.surface0,
        },
      }

      for hl, col in pairs(TelescopePrompt) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end,
  },
}
