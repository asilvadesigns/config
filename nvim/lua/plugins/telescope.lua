local function get_keys(tbl)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end
  table.sort(keys)

  local sorted_keys = {}
  for _, key in ipairs(keys) do
    table.insert(sorted_keys, { key })
  end
  return sorted_keys
end

local function formatted_name(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)

  if parent == "." then
    return tail
  end

  local cwd = vim.loop.cwd()
  parent = string.gsub(parent, cwd ~= nil and cwd or "", "")

  return string.format("%s\t\t%s", tail, parent)
end

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
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local conf = require("telescope.config").values
      local finders = require("telescope.finders")
      local pickers = require("telescope.pickers")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      --
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")
      local themes = require("telescope.themes")

      ---@class CommandPaletteEntry
      ---@field cmd string | fun(): nil
      ---@field display nil | fun(label: string): string
      ---@type table<string, CommandPaletteEntry>
      local command_palette_entries = {
        ["Commands"] = { cmd = builtin.commands },
        ["Copy file path (Absolute)"] = { cmd = "CopyAbsolutePath" },
        ["Copy file path (Relative)"] = { cmd = "CopyRelativePath" },
        ["Copy filetype"] = { cmd = "CopyFiletype" },
        ["Diagnostics"] = { cmd = "Telescope diagnostics" },
        ["Find Lines"] = { cmd = builtin.current_buffer_fuzzy_find },
        ["Find Word"] = { cmd = builtin.grep_string },
        ["Format (Biome)"] = { cmd = "FormatWithBiome" },
        ["Format (Prettier)"] = { cmd = "FormatWithPrettier" },
        ["Format (default)"] = { cmd = "Format" },
        ["Git (conflict)"] = {
          cmd = function()
            vim.cmd("GitConflictRefresh")
            vim.cmd("GitConflictListQf")
          end,
        },
        ["Git (fugitive)"] = { cmd = "Git" },
        ["Help"] = { cmd = builtin.help_tags },
        ["Keymaps"] = { cmd = "Telescope keymaps" },
        ["Lazy"] = { cmd = "Lazy" },
        ["Lint (Biome)"] = { cmd = "LintWithBiome" },
        ["Lint (EsLint)"] = { cmd = "LintWithPrettier" },
        ["Lint (default)"] = { cmd = "Lint" },
        ["Mason"] = { cmd = "Mason" },
        ["Noice dismiss"] = { cmd = "Noice dismiss" },
        ["Noice messages"] = { cmd = "Noice telescope" },
        ["Quit force"] = { cmd = "qa!" },
        ["Rename File"] = { cmd = "RenameFile" },
        ["Save"] = { cmd = "wa" },
        ["Save and quit force"] = { cmd = "wqa!" },
        ["Search"] = { cmd = "Spectre" },
        ["Symbols"] = { cmd = "Outline" },
        ["Symbols (Document)"] = { cmd = builtin.lsp_document_symbols },
        ["Symbols (Workspace)"] = { cmd = builtin.lsp_workspace_symbols },
        ["Telescope"] = { cmd = "Telescope" },
        ["Toggle Cursorline"] = {
          cmd = function()
            if vim.wo.cursorline then
              vim.cmd("tabdo windo set nocursorline")
            else
              vim.cmd("tabdo windo set cursorline")
            end
          end,
          display = function(label)
            return label .. " " .. (vim.wo.cursorline and "" or "")
          end,
        },
        ["Toggle Line Numbers"] = {
          cmd = function()
            if vim.wo.number then
              vim.cmd("tabdo windo set nornu nonu")
            else
              vim.cmd("tabdo windo set rnu nu")
            end
          end,
          display = function(label)
            return label .. " " .. (vim.wo.number and "" or "")
          end,
        },
        ["Toggle Invisible Chars"] = {
          cmd = "tabdo windo set list!",
          display = function(label)
            return label .. " " .. (vim.go.list and "" or "")
          end,
        },
        ["Toggle Wrap"] = {
          cmd = "tabdo windo set wrap!",
          display = function(label)
            return label .. " " .. (vim.go.wrap and "" or "")
          end,
        },
        ["Todos"] = { cmd = "TodoTelescope" },
        ["Todos Quickfix"] = { cmd = "TodoLocList" },
        ["Trouble"] = { cmd = "Trouble" },
        ["Zen Mode"] = { cmd = "NoNeckPain" },
        ["Zen Mode (decrease)"] = { cmd = "NoNeckPainWidthDown" },
        ["Zen Mode (increase)"] = { cmd = "NoNeckPainWidthUp" },
      }

      local command_palette_results = get_keys(command_palette_entries)

      local function command_palette(opts)
        opts = opts or {}
        pickers
          .new(opts, {
            prompt_title = "Command Palette",
            finder = finders.new_table({
              results = command_palette_results,
              entry_maker = function(entry)
                local value = command_palette_entries[entry[1]]

                return {
                  display = value.display ~= nil and value.display(entry[1]) or entry[1],
                  ordinal = entry[1],
                  value = entry,
                }
              end,
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local cmd = command_palette_entries[selection.value[1]].cmd

                if type(cmd) == "function" then
                  cmd()
                end

                if type(cmd) == "string" then
                  vim.cmd(cmd)
                end
              end)
              return true
            end,
          })
          :find()
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

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
                return math.min(max_lines, 24)
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
            path_display = formatted_name,
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
        },
        pickers = {
          buffers = {
            ignore_current_buffer = true,
            only_cwd = true,
            path_display = formatted_name,
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
            path_display = formatted_name,
          },
          git_files = {
            path_display = formatted_name,
          },
          oldfiles = {
            only_cwd = true,
            path_display = formatted_name,
            sort_mru = true,
          },
          help_tags = {},
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")

      vim.keymap.set("n", "<leader>a", function()
        command_palette()
      end)

      vim.keymap.set("n", "<leader>b", builtin.buffers)
      vim.keymap.set("n", "<leader>e", builtin.oldfiles)
      vim.keymap.set("n", "<leader>f", builtin.find_files)
      vim.keymap.set("n", "<leader>g", builtin.git_files)
      vim.keymap.set("n", "<leader>l", builtin.current_buffer_fuzzy_find)
    end,
  },
}
