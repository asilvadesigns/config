local M = {}

---@class Entry
---@field cmd string | fun(): nil
---@type table<string, Entry>
local commands = {
  ["Commands"] = "FzfLua commands",
  ["Copy file path (Absolute)"] = "CopyAbsolutePath",
  ["Copy file path (Relative)"] = "CopyRelativePath",
  ["Copy filetype"] = "CopyFiletype",
  ["Diagnostics"] = "Trouble diagnostics",
  ["Find Lines"] = "FzfLua blines",
  ["Find Word"] = "FzfLua grep_project",
  ["Format (Biome)"] = "FormatWithBiome",
  ["Format (Prettier)"] = "FormatWithPrettier",
  ["Format (default)"] = "Format",
  ["Git (Fugitive)"] = "Git",
  ["Git (Neogit)"] = "Neogit",
  ["Help"] = "FzfLua helptags",
  ["Highlights"] = "FzfLua highlights",
  ["Keymaps"] = "FzfLua keymaps",
  ["Lazy"] = "Lazy",
  ["Lint (Biome)"] = "LintWithBiome",
  ["Lint (EsLint)"] = "LintWithPrettier",
  ["Lint (default)"] = "Lint",
  ["Mason"] = "Mason",
  ["Markdown Preview"] = "MarkdownPreviewToggle",
  ["Remove All Marks"] = "delm! | delm A-Z0-9",
  ["Remove Other Buffers"] = "only|bd|e#",
  ["Rename File"] = "RenameFile",
  ["Restart LSP"] = "LspRestart",
  ["Search (global)"] = "GrugFar",
  ["Search (local)"] = "GrugFarLocal",
  ["Search"] = "Spectre",
  ["Symbols (Workspace)"] = "FzfLua lsp_workspace_symbols",
  ["Symbols"] = "FzfLua lsp_document_symbols",
  ["Todos"] = "TodoFzfLua",
  ["Toggle Color Picker"] = "ColorPickerToggle",
  ["Toggle Diagnostic Text"] = "ToggleDiagnosticText",
  ["Toggle Statusline"] = "ToggleStatusline",
  ["Toggle Winbar"] = "ToggleWinbar",
  ["Trouble"] = "Trouble",
  ["Zen Mode (no neck pain)"] = "NoNeckPain",
}

local keys = {}
for k, _ in pairs(commands) do
  table.insert(keys, k)
end

M.setup = function()
  -- local function file_to_qf(selected)
  --   local qf_list = {}
  --   for i = 1, #selected do
  --     local file = require("fzf-lua.path").entry_to_file(selected[i])
  --     local text = file.stripped:match(":%d+:%d?%d?%d?%d?:?(.*)$")
  --     table.insert(qf_list, {
  --       bufnr = file.bufnr,
  --       col = file.col,
  --       lnum = file.line > 0 and file.line or 1,
  --       filename = file.bufname or file.path or file.uri,
  --       text = text or file.stripped,
  --     })
  --   end
  --   table.sort(qf_list, function(a, b)
  --     if a.filename == b.filename then
  --       if a.lnum == b.lnum then
  --         return math.max(0, a.col) < math.max(0, b.col)
  --       else
  --         return math.max(0, a.lnum) < math.max(0, b.lnum)
  --       end
  --     else
  --       return a.filename < b.filename
  --     end
  --   end)
  --   vim.fn.setqflist(qf_list)
  --   vim.fn.setqflist({}, "a", { title = "qf list" })
  --   vim.cmd("botright copen")
  -- end

  -- local function str_to_qf(selected)
  --   vim.notify("WTF")
  --   local qf_list = {}
  --   for i = 1, #selected do
  --     local text = selected[i]
  --     vim.print("what..." .. text)
  --     -- local file = require("fzf-lua.path").entry_to_file(selected[i])
  --     -- local text = file.stripped:match(":%d+:%d?%d?%d?%d?:?(.*)$")
  --     table.insert(qf_list, {
  --       bufnr = nil,
  --       col = nil,
  --       lnum = nil,
  --       filename = text,
  --       text = text,
  --     })
  --   end
  --   table.sort(qf_list, function(a, b)
  --     if a.filename == b.filename then
  --       if a.lnum == b.lnum then
  --         return math.max(0, a.col) < math.max(0, b.col)
  --       else
  --         return math.max(0, a.lnum) < math.max(0, b.lnum)
  --       end
  --     else
  --       return a.filename < b.filename
  --     end
  --   end)
  --   vim.fn.setqflist(qf_list)
  --   vim.fn.setqflist({}, "a", { title = "qf list" })
  --   vim.cmd("botright copen")
  -- end

  require("fzf-lua").setup({
    winopts = {
      height = 0.60, -- window height
      width = 0.60, -- window width
      row = 0.50, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      backdrop = 100,
    },
    keymap = {
      builtin = {
        ["ctrl-q"] = "select-all+accept",
        ["<Esc>"] = "hide", ---https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#resume
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    ---
    ---pickers
    blines = { previewer = false },
    btags = { git_icons = false },
    buffers = { formatter = "path.filename_first", cwd_only = true },
    commands = { previewer = false },
    complete_file = { previewer = false, git_icons = false },
    diagnostics = { git_icons = false, cwd_only = true },
    files = { formatter = "path.filename_first", previewer = false, git_icons = false },
    grep = { git_icons = false },
    highlights = { previewer = true },
    lsp = { git_icons = false, cwd_only = false },
    oldfiles = { formatter = "path.filename_first", previewer = false, cwd_only = true, include_current_session = true },
    quickfix = { git_icons = false },
    tags = { git_icons = false },
  })

  local command_palette = function()
    require("fzf-lua").fzf_exec(keys, {
      actions = {
        ["default"] = function(selected)
          local cmd = commands[selected[1]]
          if type(cmd) == "function" then
            cmd()
          elseif type(cmd) == "string" then
            vim.cmd(cmd)
          end
        end,
      },
    })
  end

  -- vim.api.nvim_create_user_command("CommandPalette", command_palette, {})
  -- vim.keymap.set("n", "<leader>a", command_palette, { desc = "Fuzzy actions" })
  -- vim.keymap.set("n", "<leader>b", "<CMD>FzfLua buffers<CR>", { desc = "Fuzzy buffers" })
  -- vim.keymap.set("n", "<leader>e", "<CMD>FzfLua oldfiles<CR>", { desc = "Fuzzy oldfiles" })
  -- vim.keymap.set("n", "<leader>;", "<CMD>FzfLua resume<CR>", { desc = "Fuzzy resume" })
  -- vim.keymap.set("n", "<leader>f", "<CMD>FzfLua files<CR>", { desc = "Fuzzy files" })
  -- vim.keymap.set("n", "<leader>g", "<CMD>FzfLua live_grep<CR>", { desc = "Fuzzy grep" })
  -- vim.keymap.set("n", "<leader>l", "<CMD>FzfLua blines<CR>", { desc = "Fuzzy buffer lines" })
  -- vim.keymap.set("n", "<leader>p", function()
  --   require("fzf-lua").files({
  --     cmd = "fd . ~/dev/ --type d --max-depth 1",
  --     actions = {
  --       ["default"] = function(selected)
  --         vim.cmd("cd " .. selected[1]:match("~/.*"))
  --       end,
  --     },
  --   })
  -- end, { desc = "Fuzzy directories" })
  -- require("fzf-lua").register_ui_select()
end

return M
