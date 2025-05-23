---@diagnostic disable: missing-fields
local M = {}

---@class PaletteEntry
---@field text string
---@field cmd string | fun(): nil
---@type table<string, PaletteEntry>
local palette_items = {
  { text = "Commands", cmd = "lua Snacks.picker.commands()" },
  { text = "Colorschemes", cmd = 'lua Snacks.picker.colorschemes({ layout = { preview = "colorscheme" } })' },
  { text = "Copy file path (Absolute)", cmd = "CopyAbsolutePath" },
  { text = "Copy file path (Relative)", cmd = "CopyRelativePath" },
  { text = "Copy filetype", cmd = "CopyFiletype" },
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
  { text = "Search (file)", cmd = "GrugFarLocal" },
  { text = "Search (project)", cmd = "GrugFar" },
  { text = "Symbols", cmd = "lua Snacks.picker.lsp_symbols()" },
  { text = "Toggle Color Picker", cmd = "ColorPickerToggle" },
  { text = "Toggle Completion", cmd = "ToggleCompletion" },
  { text = "Toggle Cursor Line", cmd = "ToggleCursorLine" },
  { text = "Toggle Scrollbar", cmd = "ToggleScrollbar" },
  { text = "Toggle Diagnostic Text", cmd = "ToggleDiagnosticText" },
  { text = "Toggle Git Blame", cmd = "Gitsigns toggle_current_line_blame" },
  {
    text = "Toggle Indent Lines",
    cmd = function()
      if Snacks.indent.enabled then
        Snacks.indent.disable()
      else
        Snacks.indent.enable()
      end
    end,
  },
  { text = "Toggle Invisible Chars", cmd = "ToggleInvisibleChars" },
  { text = "Toggle Statusline", cmd = "ToggleStatusline" },
  { text = "Toggle Winbar", cmd = "ToggleWinbar" },
  { text = "Trouble", cmd = "Trouble" },
  { text = "Zen Mode (no neck pain)", cmd = "NoNeckPain" },
}

local MAX_WIDTH = 80

M.setup = function()
  require("snacks").setup({
    ---@class snacks.picker.Config
    picker = {
      enabled = true,
      layout = {
        preset = "dropdown", -- dropdown | vscode
        preview = false,
        reverse = false,
      },
      layouts = {
        dropdown = {
          layout = {
            max_height = 30,
            max_width = MAX_WIDTH,
            row = 6,
          },
        },
      },
      matcher = {
        cwd_bonus = true,
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = MAX_WIDTH,
        },
      },
      icons = {
        files = {
          enabled = false,
        },
      },
      sources = {
        ["command_palette"] = {
          format = "text",
          items = palette_items,
          layout = {
            preview = false,
          },
          confirm = function(picker, item)
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
      enabled = true,
    },
    indent = {
      enabled = true,
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
        vim.notify("killing thing!")
        ---@diagnostic disable-next-line: missing-fields
        Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
        vim.cmd("SatelliteDisable")
        vim.cmd("NoMatchParen")
        vim.cmd("TSBufDisable highlight")
        -- vim.b.minianimate_disable = true
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
            local session_found = require("auto-session").RestoreSession(vim.fn.getcwd(), { show_message = false })

            if not session_found then
              Snacks.picker.files()
            end
          end,
        },
        { key = "a", padding = 1, desc = "Actions", action = ":lua Snacks.picker.command_palette()" },
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
      enabled = false,
      animate = {
        duration = { step = 10, total = 85 },
        easing = "outSine",
      },
      animate_repeat = {
        delay = 25,
        duration = { step = 0, total = 0 },
        easing = "linear",
      },
      -- what buffers to animate
      filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
      end,
    },
  })
end

-- -- Toggle the profiler
-- Snacks.toggle.profiler():map("<leader>pp")
-- -- Toggle the profiler highlights
-- Snacks.toggle.profiler_highlights():map("<leader>ph")

vim.keymap.set("n", "<leader>a", function()
  ---@diagnostic disable-next-line: undefined-field
  Snacks.picker.command_palette()
end, { desc = "Fuzzy actions" })

vim.keymap.set("n", "<leader>b", function()
  Snacks.picker.buffers({ filter = { cwd = true } })
end, { desc = "Fuzzy buffers" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.picker.recent({ filter = { cwd = true } })
end, { desc = "Fuzzy oldfiles" })

vim.keymap.set("n", "<leader>o", function()
  Snacks.picker.lsp_symbols({
    layout = {
      preview = true,
    },
  })
end, { desc = "Fuzzy symbols" })

vim.keymap.set("n", "<leader>;", function()
  Snacks.picker.resume()
end, { desc = "Fuzzy resume" })

vim.keymap.set("n", "<leader>f", function()
  Snacks.picker.files()
end, { desc = "Fuzzy files" })

vim.keymap.set("n", "<leader>g", function()
  Snacks.picker.grep()
end, { desc = "Fuzzy grep" })

vim.keymap.set("n", "<leader>p", function()
  Snacks.picker.projects()
end, { desc = "Fuzzy projects" })

vim.keymap.set("n", "<leader>l", function()
  ---@diagnostic disable-next-line: missing-fields
  Snacks.picker.lines({
    layout = {
      preset = "dropdown",
      preview = "preview",
      reverse = false,
    },
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

return M
