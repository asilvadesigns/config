local M = {}

---@class PaletteEntry
---@field text string
---@field cmd string | fun(): nil
---@type table<string, PaletteEntry>
local palette_items = {
  {
    text = "Commands",
    cmd = function()
      Snacks.picker.commands()
    end,
  },
  { text = "Copy file path (Absolute)", cmd = "CopyAbsolutePath" },
  { text = "Copy file path (Relative)", cmd = "CopyRelativePath" },
  { text = "Copy filetype", cmd = "CopyFiletype" },
  { text = "Diagnostics", cmd = "Trouble diagnostics" },
  { text = "Format (Biome)", cmd = "FormatWithBiome" },
  { text = "Format (Prettier)", cmd = "FormatWithPrettier" },
  { text = "Format (default)", cmd = "Format" },
  { text = "Git (Fugitive)", cmd = "Git" },
  { text = "Git (Neogit)", cmd = "Neogit" },
  {
    text = "Help",
    cmd = function()
      Snacks.picker.help()
    end,
  },
  {
    text = "Highlights",
    cmd = function()
      Snacks.picker.highlights()
    end,
  },
  {
    text = "Keymaps",
    cmd = function()
      Snacks.picker.keymaps()
    end,
  },
  { text = "Lazy", cmd = "Lazy" },
  { text = "Lint (Biome)", cmd = "LintWithBiome" },
  { text = "Lint (EsLint)", cmd = "LintWithPrettier" },
  { text = "Lint (default)", cmd = "Lint" },
  { text = "Mason", cmd = "Mason" },
  { text = "Markdown Preview", cmd = "MarkdownPreviewToggle" },
  { text = "Remove All Marks", cmd = "delm! | delm A-Z0-9" },
  { text = "Remove Other Buffers", cmd = "only|bd|e#" },
  { text = "Rename File", cmd = "RenameFile" },
  { text = "Restart LSP", cmd = "LspRestart" },
  { text = "Search (global)", cmd = "GrugFar" },
  { text = "Search (local)", cmd = "GrugFarLocal" },
  { text = "Search", cmd = "Spectre" },
  {
    text = "Symbols",
    cmd = function()
      Snacks.picker.lsp_symbols()
    end,
  },
  { text = "Todos", cmd = "TodoFzfLua" },
  { text = "Toggle Color Picker", cmd = "ColorPickerToggle" },
  { text = "Toggle Diagnostic Text", cmd = "ToggleDiagnosticText" },
  { text = "Toggle Statusline", cmd = "ToggleStatusline" },
  { text = "Toggle Winbar", cmd = "ToggleWinbar" },
  { text = "Trouble", cmd = "Trouble" },
  { text = "Zen Mode (no neck pain)", cmd = "NoNeckPain" },
}

M.setup = function()
  require("snacks").setup({
    ---@class snacks.picker.Config
    picker = {
      enabled = true,
      layout = {
        preset = "dropdown", ---{ backdrop = false, box = "vertical" },
        reverse = false,
      },
      sources = {
        ["command_palette"] = {
          format = "text",
          items = palette_items,
          confirm = function(picker, item)
            local cmd = item.cmd
            if type(cmd) == "function" then
              cmd()
            elseif type(cmd) == "string" then
              vim.cmd(cmd)
            end
            picker:close()
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
    ---@class snacks.profiler.Config
    profiler = {
      enabled = true,
    },
    ---@class snacks.indent.Config
    indent = {
      enabled = false,
      only_current = true,
      animate = { enabled = false },
      chunk = { enabled = false },
      scope = { enabled = true },
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
        { key = "s", padding = 1, desc = "Session Restore", action = ":SessionRestore" },
        { key = "a", padding = 1, desc = "Actions", action = ":CommandPalette" },
        { key = "f", padding = 1, desc = "Find File", action = ":FzfLua files" }, --:Telescope find_files
        { key = "e", padding = 1, desc = "Recent Files", action = ":FzfLua oldfiles" }, --:Telescope oldfiles
        { key = "l", padding = 1, desc = "Lazy", action = ":Lazy" },
        { key = "m", padding = 1, desc = "Mason", action = ":Mason" },
        { key = "q", padding = 1, desc = "Quit", action = ":qa!" },
        { section = "startup" },
      },
    },
    ---@class snacks.statuscolumn.Config
    statuscolumn = {
      enabled = true,
      -- "sign"
      left = { "git", "mark" }, -- priority of signs on the left (high to low)
      right = { "fold" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    ---@class snacks.input.Config
    input = {
      enabled = false,
      prompt_pos = "",
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
  Snacks.picker.buffers()
end, { desc = "Fuzzy buffers" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.picker.recent()
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
  Snacks.picker.lines({
    layout = {
      preset = "dropdown",
      reverse = false,
    },
  })
end, { desc = "Fuzzy buffer lines" })

return M
