local M = {}

M.setup = function()
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
    ["Diagnostics"] = { cmd = "Trouble diagnostics" },
    ["Find Lines"] = { cmd = builtin.current_buffer_fuzzy_find },
    ["Find Word"] = { cmd = builtin.grep_string },
    ["Format (Biome)"] = { cmd = "FormatWithBiome" },
    ["Format (Prettier)"] = { cmd = "FormatWithPrettier" },
    ["Format (default)"] = { cmd = "Format" },
    ["Git (Fugitive)"] = { cmd = "Git" },
    ["Git (Neogit)"] = { cmd = "Neogit" },
    ["Help"] = { cmd = builtin.help_tags },
    ["Highlights"] = { cmd = builtin.highlights },
    ["Keymaps"] = { cmd = "Telescope keymaps" },
    ["Lazy"] = { cmd = "Lazy" },
    ["Lint (Biome)"] = { cmd = "LintWithBiome" },
    ["Lint (EsLint)"] = { cmd = "LintWithPrettier" },
    ["Lint (default)"] = { cmd = "Lint" },
    ["Mason"] = { cmd = "Mason" },
    ["Markdown Preview"] = { cmd = "MarkdownPreviewToggle" },
    ["Remove All Marks"] = "delm! | delm A-Z0-9",
    ["Remove Other Buffers"] = "only|bd|e#",
    ["Noice dismiss"] = { cmd = "Noice dismiss" },
    ["Noice messages"] = { cmd = "Noice telescope" },
    ["Open (Finder)"] = { cmd = "!open ." },
    ["Rename File"] = { cmd = "RenameFile" },
    ["Restart LSP"] = { cmd = "LspRestart" },
    ["Search"] = { cmd = "Spectre" },
    ["Search (local)"] = { cmd = "GrugFarLocal" },
    ["Search (global)"] = { cmd = "GrugFar" },
    ["Symbols"] = { cmd = "Trouble symbols" },
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
    ["Toggle Diagnostic Text"] = {
      cmd = "ToggleDiagnosticText",
      display = function(label)
        local config = vim.diagnostic.config()
        if config == nil then
          return label .. " " .. ""
        else
          return label .. " " .. (config.virtual_text and "" or "")
        end
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
    ["Zen Mode (folke)"] = { cmd = "ZenMode" },
    ["Zen Mode (no neck pain)"] = { cmd = "NoNeckPain" },
    ["Zen Mode (decrease)"] = { cmd = "NoNeckPainWidthDown" },
    ["Zen Mode (increase)"] = { cmd = "NoNeckPainWidthUp" },
  }

  local command_palette_results = get_keys(command_palette_entries)

  local function command_palette(opts)
    opts = opts or {}
    pickers
      .new(opts, {
        prompt_title = "Actions",
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

            vim.schedule(function()
              if type(cmd) == "function" then
                cmd()
              elseif type(cmd) == "string" then
                vim.cmd(cmd)
              else
                print("Invalid command type: " .. type(cmd))
              end
            end)
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
    defaults = themes.get_dropdown({
      layout_config = {
        width = function(_, max_columns, _)
          return math.min(max_columns, 100)
        end,
        height = function(_, _, max_lines)
          return math.min(max_lines, 24)
        end,
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-u>"] = false,
          ["<esc>"] = actions.close,
        },
      },
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",
    }),
    pickers = {
      colorscheme = {
        disable_devicons = true,
        enable_preview = true,
      },
      buffers = {
        disable_devicons = true,
        ignore_current_buffer = true,
        previewer = false,
        show_all_buffers = false,
      },
      find_files = {
        find_command = { "rg", "--no-config", "--files", "--sortr=modified" },
        disable_devicons = true,
        hidden = true,
        previewer = false,
        file_ignore_patterns = {
          "%.git/.",
          -- npm
          "node_modules",
          "package-lock.json",
          "pnpm-lock.yaml",
          -- templ
          "_templ%.go$",
          "_templ%.txt$",
        },
      },
      current_buffer_fuzzy_find = {
        results_ts_highlight = true,
        previewer = false,
      },
      git_files = {
        disable_devicons = true,
        previewer = false,
      },
      oldfiles = {
        disable_devicons = true,
        only_cwd = true,
        previewer = false,
      },
    },
  })

  vim.api.nvim_create_user_command("CommandPalette", function()
    command_palette()
  end, {})

  vim.keymap.set("n", "<leader>a", command_palette, {
    desc = "Fuzzy actions",
  })

  vim.keymap.set("n", "<leader>b", builtin.buffers, {
    desc = "Fuzzy buffers",
  })

  vim.keymap.set("n", "<leader>e", builtin.oldfiles, {
    desc = "Fuzzy old files",
  })

  vim.keymap.set("n", "<leader>f", builtin.find_files, {
    desc = "Fuzzy find files",
  })

  vim.keymap.set("n", "<leader>g", builtin.live_grep, {
    desc = "Fuzzy live grep",
  })

  vim.keymap.set("n", "<leader>l", builtin.current_buffer_fuzzy_find, {
    desc = "Fuzzy current buffer",
  })

  telescope.load_extension("ui-select")
  telescope.load_extension("zf-native")

  vim.api.nvim_set_hl(0, "TelescopeMatching", {
    bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextWarn"), "bg"),
    fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextWarn"), "fg"),
    italic = false,
    underline = false,
  })
end

return M
