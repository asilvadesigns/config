---@diagnostic disable: missing-fields
local M = {}

---@param message string
---@param enabled boolean
local drawToggle = function(message, enabled)
  local status = ""

  if enabled then
    status = ""
  end

  return status .. " " .. message
end

---@class PaletteEntry
---@field text string
---@field cmd string | fun(): nil
---@return table<string, PaletteEntry>
local palette_items = function()
  return {
    { text = "Commands", cmd = "lua Snacks.picker.commands()" },
    { text = "Colorschemes", cmd = 'lua Snacks.picker.colorschemes({ layout = { preview = "colorscheme" } })' },
    { text = "Copy file path (Absolute)", cmd = "CopyAbsolutePath" },
    { text = "Copy file path (Relative)", cmd = "CopyRelativePath" },
    { text = "Copy filetype", cmd = "CopyFiletype" },
    { text = "Datetime", cmd = "Datetime" },
    { text = "Diagnostics", cmd = "Trouble diagnostics" },
    { text = "Fold (level 0 or reset)", cmd = "setlocal foldlevel=99" },
    { text = "Fold (level 1)", cmd = "setlocal foldlevel=0" },
    { text = "Fold (level 2)", cmd = "setlocal foldlevel=1" },
    { text = "Fold (level 3)", cmd = "setlocal foldlevel=2" },
    { text = "Fold (level 4)", cmd = "setlocal foldlevel=3" },
    { text = "Format (Biome)", cmd = "FormatWithBiome" },
    { text = "Format (Lsp)", cmd = "FormatWithLsp" },
    { text = "Format (Prettier)", cmd = "FormatWithPrettier" },
    { text = "Format (default)", cmd = "Format" },
    { text = "Git (Fugitive)", cmd = "Git" },
    { text = "Git (Neogit)", cmd = "Neogit" },
    { text = "Help", cmd = "lua Snacks.picker.help()" },
    { text = "Highlights", cmd = "lua Snacks.picker.highlights()" },
    { text = "Keymaps", cmd = "lua Snacks.picker.keymaps()" },
    { text = "Lazy", cmd = "Lazy" },
    { text = "Lint (Biome)", cmd = "LintWithBiome" },
    { text = "Lint (EsLint)", cmd = "LintWithPrettier" },
    { text = "Lint (default)", cmd = "Lint" },
    { text = "Markdown Preview", cmd = "MarkdownPreviewToggle" },
    { text = "Mason", cmd = "Mason" },
    { text = "Notifications", cmd = "lua Snacks.notifier.show_history()" },
    { text = "Remove All Marks", cmd = "delm! | delm A-Z0-9" },
    { text = "Remove Other Buffers", cmd = "only|bd|e#" },
    { text = "Rename File", cmd = "RenameFile" },
    { text = "Restart LSP", cmd = "LspRestart" },
    { text = "Search (file)", cmd = "SearchFile" },
    { text = "Search (project)", cmd = "SearchProject" },
    { text = "Show Line Numbers", cmd = "ShowLineNumbers" },
    { text = "Show Relative Numbers", cmd = "ShowRelativeLineNumbers" },
    { text = "Hide Line Numbers", cmd = "HideLineNumbers" },
    { text = "Symbols", cmd = "lua Snacks.picker.lsp_symbols()" },
    { text = drawToggle("Toggle Auto Pairs", _G.enable_auto_pair), cmd = "ToggleAutoPairs" },
    { text = drawToggle("Toggle Color Picker", _G.enable_color_picker), cmd = "ColorPickerToggle" },
    { text = drawToggle("Toggle Completion", _G.enable_autocompletion), cmd = "ToggleCompletion" },
    { text = drawToggle("Toggle Context", _G.show_treesitter_context), cmd = "ToggleTreesitterContext" },
    { text = drawToggle("Toggle Cursor Line", _G.show_cursorline), cmd = "ToggleCursorLine" },
    { text = drawToggle("Toggle Diagnostics", _G.show_diagnostics), cmd = "ToggleDiagnostics" },
    { text = drawToggle("Toggle Diagnostic Text", _G.show_diagnostics_text), cmd = "ToggleDiagnosticText" },
    {
      text = drawToggle("Toggle Diagnostic Underline", _G.show_diagnostics_underline),
      cmd = "ToggleDiagnosticUnderline",
    },
    { text = "Toggle Git Blame", cmd = "Gitsigns toggle_current_line_blame" },
    { text = drawToggle("Toggle Hide All", _G.hide_all), cmd = "ToggleHideAll" },
    { text = drawToggle("Toggle Illuminate", _G.show_illuminate), cmd = "ToggleIlluminate" },
    { text = drawToggle("Toggle Indent Lines", _G.show_indent_lines), cmd = "ToggleIndentLines" },
    { text = drawToggle("Toggle Inlay Hints", _G.show_inlay_hints), cmd = "ToggleInlayHints" },
    { text = drawToggle("Toggle Invisible Chars", _G.show_invisible_chars), cmd = "ToggleInvisibleChars" },
    -- { text = drawToggle("Toggle Line Numbers", _G.show_number_lines), cmd = "ToggleNumberLines" },
    { text = drawToggle("Toggle Line Wrap", _G.enable_line_wrap), cmd = "ToggleLineWrap" },
    -- { text = drawToggle("Toggle Relative Lines", _G.show_relative_lines), cmd = "ToggleRelativeLines" },
    { text = drawToggle("Toggle Scrollbar", _G.show_scrollbar), cmd = "ToggleScrollbar" },
    { text = drawToggle("Toggle Smooth Scroll", _G.enable_smooth_scroll), cmd = "ToggleSmoothScroll" },
    { text = drawToggle("Toggle Statusline", _G.show_statusline), cmd = "ToggleStatusline" },
    { text = drawToggle("Toggle Syntax Highlight", _G.enable_syntax_highlight), cmd = "ToggleSyntaxHighlight" },
    { text = drawToggle("Toggle Winbar", _G.show_winbar), cmd = "ToggleWinbar" },
    { text = drawToggle("Toggle Zen Mode", _G.enable_zen_mode), cmd = "ToggleZenMode" },
    { text = drawToggle("Trouble", _G.trouble_visible), cmd = "Trouble" },
  }
end

local MAX_WIDTH = 140
local PRESET = "dropdown" -- dropdown | vscode | ivy | select

M.setup = function()
  require("snacks").setup({
    ---@class snacks.picker.Config
    picker = {
      enabled = true,
      layout = {
        preset = PRESET, -- dropdown | vscode | ivy | select
        preview = false,
        reverse = false,
      },
      layouts = {
        select = {
          layout = {
            max_height = 40,
            max_width = MAX_WIDTH,
            width = 0.8,
            height = 0.8,
          },
        },
        dropdown = {
          layout = {
            max_height = 40,
            max_width = MAX_WIDTH,
            width = 0.8,
            height = 0.6,
            row = 6,
          },
        },
        vscode = {
          layout = {
            border = "none",
            height = 0.6,
            row = 4,
          },
        },
      },
      matcher = {
        cwd_bonus = true,
        frecency = true,
      },
      formatters = {
        file = {
          filename_first = false,
          truncate = MAX_WIDTH,
        },
      },
      icons = {
        files = {
          enabled = true,
        },
      },
      sources = {
        ["command_palette"] = {
          format = "text",
          layout = {
            preview = false,
          },
          confirm = function(picker, item)
            --- TODO: could add logic such that if an item is a toggle to keep open for visualizing the toggle.
            picker:close()
            vim.schedule(function()
              local cmd = item.cmd
              if type(cmd) == "function" then
                cmd()
              elseif type(cmd) == "string" then
                vim.cmd(cmd)
              end
            end)
          end,
        },
      },
      ui_select = true,
      win = {
        input = {
          keys = {
            ["<C-c>"] = { "close" },
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<c-u>"] = { "list_scroll_up", mode = { "n" } },
          },
        },
      },
    },
    input = {
      enabled = false,
    },
    styles = {
      notification_history = {
        backdrop = false,
        position = "bottom",
      },
    },
    profiler = {
      enabled = false,
    },
    indent = {
      enabled = _G.show_indent_lines,
      only_current = true,
      animate = { enabled = false },
      chunk = { enabled = false },
      scope = { enabled = false }, --use this for current scope
    },
    bigfile = {
      enabled = true,
      notify = true,
      size = 1 * 1024 * 1000, -- 1MB
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        vim.notify("large file detected")
        Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })

        if vim.fn.exists(":DisableLineWrap") > 0 then
          vim.cmd("DisableLineWrap")
        end

        if vim.fn.exists(":SatelliteDisable") > 0 then
          vim.cmd("SatelliteDisable")
        end

        if vim.fn.exists(":NoMatchParen") > 0 then
          vim.cmd("NoMatchParen")
        end

        if vim.fn.exists(":TSBufDisable") > 0 then
          vim.cmd("TSBufDisable highlight")
        end

        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
        end)
      end,
    },
    dashboard = {
      enabled = true,
      sections = {
        {
          key = "s",
          padding = 1,
          desc = "Session Restore",
          action = function()
            local session_found = require("auto-session").restore_session(vim.fn.getcwd(), { show_message = false })

            if not session_found then
              Snacks.picker.files()
            end
          end,
        },
        { key = "a", padding = 1, desc = "Actions", action = ":Actions" },
        { key = "f", padding = 1, desc = "Find File", action = ":lua Snacks.picker.files()" },
        { key = "e", padding = 1, desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
        { key = "l", padding = 1, desc = "Lazy", action = ":Lazy" },
        { key = "m", padding = 1, desc = "Mason", action = ":Mason" },
        { key = "q", padding = 1, desc = "Quit", action = ":qa!" },
        { section = "startup" },
      },
    },
    notifier = {
      enabled = true,
      style = "compact",
      timeout = 1000,
      width = {
        min = 40,
        max = 40,
      },
    },
    statuscolumn = {
      enabled = true,
      -- "sign"
      -- left = { "git", "sign", "mark" }, -- priority of signs on the left (high to low)
      left = { "sign" }, -- priority of signs on the left (high to low)
      right = { "fold" }, -- priority of signs on the right (high to low)
      -- right = {}, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
      },
      git = {
        patterns = {
          "GitSign",
          "MiniDiffSign",
        },
      },
      refresh = 50,
    },
    scroll = {
      enabled = _G.enable_smooth_scroll,
      animate = {
        duration = { step = 25, total = 125 },
        easing = "outSine",
      },
      animate_repeat = {
        delay = 50,
        duration = { step = 5, total = 50 },
        easing = "linear",
      },
    },
  })

  --- actions
  vim.api.nvim_create_user_command("Actions", function()
    --- @diagnostic disable-next-line: undefined-field
    Snacks.picker.command_palette({ items = palette_items() })
  end, {})
  vim.keymap.set("n", "<leader>a", ":Actions<CR>", { desc = "Fuzzy actions", silent = true })

  --- buffers
  vim.keymap.set("n", "<leader>b", function()
    Snacks.picker.buffers({ filter = { cwd = true } })
  end, { desc = "Fuzzy buffers" })

  --- recent
  vim.keymap.set("n", "<leader>e", function()
    Snacks.picker.recent({ filter = { cwd = true } })
  end, { desc = "Fuzzy oldfiles" })

  --- symbols
  vim.keymap.set("n", "<leader>o", function()
    Snacks.picker.lsp_symbols({
      filter = {
        default = {
          "Class",
          "Constructor",
          -- "Enum",
          -- "Field",
          "Function",
          "Interface",
          "Method",
          -- "Module",
          -- "Namespace",
          -- "Package",
          "Property",
          -- "Struct",
          -- "Trait",
        },
      },
      layout = {
        preset = PRESET,
        preview = true,
      },
    })
  end, { desc = "Fuzzy symbols" })

  --- resume
  vim.keymap.set("n", "<leader><leader>", function()
    Snacks.picker.resume()
  end, { desc = "Fuzzy resume" })

  --- files
  vim.keymap.set("n", "<leader>f", function()
    Snacks.picker.files()
  end, { desc = "Fuzzy files" })

  --- grep
  vim.keymap.set("n", "<leader>g", function()
    Snacks.picker.grep()
  end, { desc = "Fuzzy grep" })

  --- projects
  vim.keymap.set("n", "<leader>p", function()
    Snacks.picker.projects()
  end, { desc = "Fuzzy projects" })

  --- lines
  vim.keymap.set("n", "<leader>l", function()
    ---@diagnostic disable-next-line: missing-fields
    Snacks.picker.lines({
      layout = {
        preset = PRESET,
        preview = "preview",
        reverse = false,
      },
      -- on_close = function(picker)
      --   if (picker.input) then
      --
      --   end
      -- end
      -- sort = {
      --   fields = { "idx" }, --- could add "score:desc", for fuzzy match score
      -- },
    })
  end, { desc = "Fuzzy buffer lines" })

  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(vim.lsp.status(), "info", {
        id = "lsp_progress",
        title = "LSP Progress",
        opts = function(notif)
          notif.icon = ev.data.params.value.kind == "end" and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })

  ---
  --- Section: Toggle Indent Lines
  ---
  vim.api.nvim_create_user_command("ToggleIndentLines", function()
    if Snacks.indent.enabled then
      Snacks.indent.disable()
    else
      Snacks.indent.enable()
    end
    _G.show_indent_lines = not _G.show_indent_lines
  end, {})

  ---
  --- Section: Disable Snacks Animation During Blink CMP
  ---
  --- https://github.com/Saghen/blink.cmp/issues/1710#issuecomment-2868735177
  local group = vim.api.nvim_create_augroup("BlinkCmpSnacksToggle", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "BlinkCmpMenuOpen",
    callback = function()
      vim.g.snacks_animate = false
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "BlinkCmpMenuClose",
    callback = function()
      vim.g.snacks_animate = true
    end,
  })

  ---
  --- Section: Toggle Smooth Scroll
  ---
  -- local scroll_group = vim.api.nvim_create_augroup("SmartScrollSnacks", { clear = true })
  -- local debounce = false
  --
  -- -- Create one autocmd ahead of time; just reacts when debounce=true
  -- vim.api.nvim_create_autocmd("CursorMoved", {
  --   group = scroll_group,
  --   callback = function()
  --     if debounce then
  --       Snacks.scroll.enable()
  --       debounce = false
  --     end
  --   end,
  -- })
  --
  -- local function smart_scroll(direction)
  --   local motion = direction == "up" and "gk" or "gj"
  --   if not debounce then
  --     Snacks.scroll.disable()
  --     debounce = true
  --   end
  --   return motion
  -- end
  --
  -- local function toggle_smooth_scroll()
  --   if _G.enable_smooth_scroll then
  --     Snacks.scroll.enable()
  --
  --     vim.keymap.set({ "n", "v" }, "k", function()
  --       return smart_scroll("up")
  --     end, { expr = true, silent = true })
  --
  --     vim.keymap.set({ "n", "v" }, "j", function()
  --       return smart_scroll("down")
  --     end, { expr = true, silent = true })
  --
  --     return
  --   end
  --
  --   Snacks.scroll.disable()
  --   pcall(vim.keymap.del, { "n", "v" }, "k")
  --   pcall(vim.keymap.del, { "n", "v" }, "j")
  -- end
  --
  vim.api.nvim_create_user_command("ToggleSmoothScroll", function()
    _G.enable_smooth_scroll = not _G.enable_smooth_scroll
    if _G.enable_smooth_scroll then
      Snacks.scroll.enable()
    else
      Snacks.scroll.disable()
    end
  end, {})
end

return M
