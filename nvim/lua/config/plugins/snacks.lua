---@diagnostic disable: missing-fields
local M = {}

---@class PaletteEntry
---@field text string
---@field cmd string | fun(): nil
---@type table<string, PaletteEntry>
local palette_items = {
  { text = "Commands", cmd = "lua Snacks.picker.commands()" },
  { text = "Copy file path (Absolute)", cmd = "CopyAbsolutePath" },
  { text = "Copy file path (Relative)", cmd = "CopyRelativePath" },
  { text = "Copy filetype", cmd = "CopyFiletype" },
  { text = "Diagnostics", cmd = "Trouble diagnostics" },
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
  { text = "Todos", cmd = "TodoFzfLua" },
  { text = "Toggle Color Picker", cmd = "ColorPickerToggle" },
  {
    text = "Toggle Diagnostic Text",
    cmd = function()
      local status_ok, _ = pcall(require, "tiny-inline-diagnostic")
      if status_ok then
        vim.cmd("ToggleDiagnosticTiny")
      else
        vim.cmd("ToggleDiagnosticText")
      end
    end,
  },
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
        preset = "dropdown",
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
    ---@class snacks.input.Config
    input = {
      enabled = false,
    },
    ---@type table<string, snacks.win.Config>
    styles = {
      notification_history = {
        backdrop = false,
        position = "bottom",
      },
    },
    ---@class snacks.profiler.Config
    profiler = {
      enabled = true,
    },
    ---@class snacks.indent.Config
    indent = {
      enabled = true,
      only_current = true,
      animate = { enabled = false },
      chunk = { enabled = false },
      scope = { enabled = false },
    },
    ---@class snacks.bigfile.Config
    bigfile = {
      enabled = true,
      notify = true,
      size = 1 * 1024 * 1024, -- 1.0MB
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        -- vim.cmd([[NoMatchParen]])
        ---@diagnostic disable-next-line: missing-fields
        Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
        -- vim.b.minianimate_disable = true
        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
        end)
      end,
    },
    ---@class snacks.dashboard.Config
    dashboard = {
      enabled = true,
      sections = {
        {
          key = "s",
          padding = 1,
          desc = "Session Restore",
          action = function()
            require("auto-session").RestoreSession(vim.fn.getcwd(), { show_message = false })
          end,
        },
        { key = "a", padding = 1, desc = "Actions", action = ":lua Snacks.picker.command_palette()" },
        { key = "f", padding = 1, desc = "Find File", action = ":lua Snacks.picker.files()" }, --:Telescope find_files
        { key = "e", padding = 1, desc = "Recent Files", action = ":lua Snacks.picker.recent()" }, --:Telescope oldfiles
        { key = "l", padding = 1, desc = "Lazy", action = ":Lazy" },
        { key = "m", padding = 1, desc = "Mason", action = ":Mason" },
        { key = "q", padding = 1, desc = "Quit", action = ":qa!" },
        { section = "startup" },
      },
    },
    ---@class snacks.notifier.Config
    notifier = {
      enabled = true,
      style = "compact",
      timeout = 1000,
      width = { min = 40, max = 40 },
    },
    ---@class snacks.statuscolumn.Config
    statuscolumn = {
      enabled = true,
      -- "sign"
      left = { "git", "sign", "mark" }, -- priority of signs on the left (high to low)
      right = { "fold" }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    ---@class snacks.scroll.Config
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 15, total = 75 }, --5 && 125 is good
        easing = "inOutSine",
        fps = 60,
      },
      spamming = 10, -- threshold for spamming detection
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

vim.cmd("hi! link SnacksIndent WinSeparator")

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
