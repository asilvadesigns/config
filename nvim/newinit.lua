local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

---
--- Options
---
_G.enable_auto_pair = false
_G.enable_autocompletion = false
_G.enable_color_picker = false
_G.enable_syntax_highlight = true
_G.enable_line_wrap = false
_G.enable_smooth_scroll = true
_G.enable_simple_colors = false
_G.enable_zen_mode = false
_G.grug_instance_global = "grug-instance-global"
_G.grug_instance_local = "grug-instance-local"
_G.show_cursorline = true
_G.show_diagnostics = false
_G.show_diagnostics_text = false
_G.show_diagnostics_underline = false
_G.show_illuminate = true
_G.show_indent_lines = false
_G.show_inlay_hints = false
_G.show_invisible_chars = false
_G.show_scrollbar = false
_G.show_treesitter_context = false
_G.hide_all = false
_G.show_statusline = false
_G.show_winbar = true

vim.g.mapleader = ","
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.cursorline = _G.show_cursorline
vim.opt.diffopt = "internal,filler,closeoff,linematch:60"
vim.opt.expandtab = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] --   ||   ||  

vim.opt.foldcolumn = "0" -- "0" to hide folds. "1" to show.
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"

vim.opt.modeline = false --- may want these some day but having issues with markdown files
vim.opt.guicursor =
  "n-v-c:blocki,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait500-blinkoff250-blinkon250,sm:block-blinkwait500-blinkoff250-blinkon250"
vim.opt.ignorecase = true
vim.opt.list = show_invisible_chars
vim.opt.listchars = "nbsp:+,trail:·,extends:,precedes:,space:·,tab:»»" -- NOTE: tab must have 2 characters
vim.opt.redrawtime = 1500
vim.opt.scrolloff = 0
vim.opt.sessionoptions = "buffers,curdir,winsize,winpos" -- could include localoptions
vim.opt.shiftwidth = 2
vim.opt.showbreak = "↳  " -- slow on huge linebreaks for some reason
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 1
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.synmaxcol = 256
vim.opt.tabstop = 2
vim.opt.updatetime = 100

-- vim.opt.statuscolumn = "%s %r %l"

if not _G.enable_line_wrap then
  vim.cmd("set nowrap nolinebreak")
else
  vim.cmd("set wrap linebreak")
end

-- line numbers FTW
vim.cmd("set nonu nornu")

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono"
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  -- vim.g.neovide_scroll_animation_length = 0.05
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
  -- TODO: at some point add hotkeys for modifying font size.
end

---
--- Keymaps
---
vim.keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Clear highlight" })

vim.keymap.set("i", "<c-l>", "<ESC>A", { desc = "Go to end of line" })
vim.keymap.set("i", "<c-h>", "<ESC>I", { desc = "Go to start of line" })

vim.keymap.set("n", "z1", "<CMD>setlocal foldlevel=0<CR>", { desc = "Fold level 1" })
vim.keymap.set("n", "z2", "<CMD>setlocal foldlevel=1<CR>", { desc = "Fold level 2" })
vim.keymap.set("n", "z3", "<CMD>setlocal foldlevel=2<CR>", { desc = "Fold level 3" })
vim.keymap.set("n", "z4", "<CMD>setlocal foldlevel=3<CR>", { desc = "Fold level 4" })
vim.keymap.set("n", "z0", "<CMD>setlocal foldlevel=99<CR>", { desc = "Reset fold level" })

vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>")

vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Focus bottom window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Focus top window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Focus right window" })

vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close this window" })

vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })

vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Go to the left window" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Go to the down window" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Go to the up window" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Go to the right window" })

vim.keymap.set("n", "<leader>d", "<C-d>", { desc = "Scroll down" })
vim.keymap.set("n", "<leader>u", "<C-u>", { desc = "Scroll up" })

vim.keymap.set("n", "<leader>s", ":silent! w<CR>", { desc = "Save", silent = true })

vim.keymap.set("n", "<leader>qf", function()
  if vim.bo.filetype == "NvimTree" then
    require("nvim-tree.api").tree.close()
  end

  if vim.bo.filetype == "oil" then
    require("oil").close()
  end

  vim.cmd("qa!")
end, { desc = "Save and Quit" })

vim.keymap.set("n", "<", ":tabprevious<CR>", { desc = "Go to the previous tab" })
vim.keymap.set("n", ">", ":tabnext<CR>", { desc = "Go to the next tab" })
vim.keymap.set("n", "tl", ":tablast<CR>", { desc = "Go to the last tab" })
vim.keymap.set("n", "tn", ":tabnew<CR>", { desc = "Create new tab" })
vim.keymap.set("n", "to", ":tabonly<CR>", { desc = "Close other tabs" })
vim.keymap.set("n", "tq", ":tabclose<CR>", { desc = "Close this tab" })

vim.keymap.set("n", "<leader>1", ":tabn 1<CR>", { desc = "Go to tab 1" })
vim.keymap.set("n", "<leader>2", ":tabn 2<CR>", { desc = "Go to tab 2" })
vim.keymap.set("n", "<leader>3", ":tabn 3<CR>", { desc = "Go to tab 3" })
vim.keymap.set("n", "<leader>4", ":tabn 4<CR>", { desc = "Go to tab 4" })
vim.keymap.set("n", "<leader>5", ":tabn 5<CR>", { desc = "Go to tab 5" })
vim.keymap.set("n", "<leader>6", ":tabn 6<CR>", { desc = "Go to tab 6" })
vim.keymap.set("n", "<leader>7", ":tabn 7<CR>", { desc = "Go to tab 7" })
vim.keymap.set("n", "<leader>8", ":tabn 8<CR>", { desc = "Go to tab 8" })
vim.keymap.set("n", "<leader>9", ":tabn 9<CR>", { desc = "Go to tab 9" })

vim.keymap.set("v", "<Tab>", ">gv", { desc = "Add indent" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Remove indent " })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste" })

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-c>", [[<C-\><C-n>]])

-- @see: https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to prev diagnostic message" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = "ERROR" })
end, { desc = "Go to prev error message" })

vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = "ERROR" })
end, { desc = "Go to next error message" })

vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostic message" })

vim.keymap.set("n", "]c", ":cnext<CR>", { desc = "Go to next quickfix item" })

vim.keymap.set("n", "[c", ":cprev<CR>", { desc = "Go to prev quickfix item" })

-- Disable plugin/ directory auto-loading for plugins we configure manually
vim.g.loaded_nvim_treesitter_textobjects = 1

-- deps
local deps = require("mini.deps")
deps.setup({ path = { package = path_package } })

deps.add({ source = "nvim-tree/nvim-web-devicons" })

deps.add({ source = "nvim-lua/plenary.nvim" })

deps.add({ source = "folke/snacks.nvim" })
deps.now(function()
  require("config.plugins.snacks").setup()
end)

deps.add({ source = "folke/ts-comments.nvim" })

deps.add({ source = "rmagatti/auto-session" })
deps.now(require("config.plugins.auto-session").setup)

deps.add({ source = "catppuccin/nvim" })
deps.now(require("config.plugins.catppuccin").setup)

deps.add({ source = "stevearc/quicker.nvim" })
deps.later(require("config.plugins.quicker").setup)

deps.add({
  source = "eero-lehtinen/oklch-color-picker.nvim",
  hooks = {
    post_install = function()
      vim.fn.system({ "npm", "install" })
      vim.fn.system({ "npm", "run", "build" })
    end,
  },
})
deps.later(require("config.plugins.color-picker").setup)

deps.add({
  source = "mrjones2014/smart-splits.nvim"
})
deps.later(function()
    require("config.plugins.smart-splits").setup()
    local splits = require('smart-splits')
    vim.keymap.set("n", "<C-h>", splits.move_cursor_left, { desc = "Move cursor left" })
    vim.keymap.set("n", "<C-j>", splits.move_cursor_down, { desc = "Move cursor down" })
    vim.keymap.set("n", "<C-k>", splits.move_cursor_up, { desc = "Move cursor up" })
    vim.keymap.set("n", "<C-l>", splits.move_cursor_right, { desc = "Move cursor right" })
end)

deps.add({
    source = "jake-stewart/multicursor.nvim",
    monitor = "1.0",
})
deps.later(require("config.plugins.multicursor").setup)

deps.add({
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "main",
  hooks = {
    post_checkout = function()
      vim.cmd("TSUpdate")
    end,
  },
})
deps.now(require("config.plugins.treesitter").setup)

deps.add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  depends = { "nvim-treesitter/nvim-treesitter" },
  checkout = "main",
})
deps.later(function()
  local select = require("nvim-treesitter-textobjects.select")
  vim.keymap.set({"x", "o"}, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "around function" })
  vim.keymap.set({"x", "o"}, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "inside function" })
end)

deps.add({
  source = "nvim-treesitter/nvim-treesitter-context",
  checkout = "main",
  depends = { "nvim-treesitter/nvim-treesitter" },
})
deps.later(require("config.plugins.treesitter-context").setup)

deps.add({ source = "nvim-tree/nvim-tree.lua" })
deps.later(require("config.plugins.nvim-tree").setup)

deps.add({ source = "stevearc/oil.nvim" })
deps.later(require("config.plugins.oil").setup)

deps.add({
  source = "mvllow/modes.nvim",
  monitor = "v0.2.1",
})
deps.later(require("config.plugins.modes").setup)

deps.add({ source = "folke/trouble.nvim" })
deps.later(require("config.plugins.trouble").setup)

deps.add({ source = "folke/lazydev.nvim" })
deps.later(function()
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  })
end)

deps.add({ source = "petertriho/nvim-scrollbar" })
deps.later(require("config.plugins.scrollbar").setup)

deps.add({ source = "stevearc/conform.nvim" })
deps.later(require("config.plugins.conform").setup)

deps.add({ source = "axelvc/template-string.nvim" })
deps.later(function()
  require("template-string").setup({})
end)

deps.add({ source = "gbprod/substitute.nvim" })
deps.later(function()
  require("substitute").setup({})
  vim.keymap.set("x", "X", function() require("substitute.exchange").visual() end, { desc = "Exchange" })
end)

deps.add({ source = "kylechui/nvim-surround" })
deps.later(function()
  require("nvim-surround").setup({})
end)

deps.add({ source = "max397574/better-escape.nvim" })
deps.later(require("config.plugins.better-escape").setup)

deps.add({ source = "shortcuts/no-neck-pain.nvim" })
deps.later(require("config.plugins.no-neck-pain").setup)

deps.add({ source = "williamboman/mason.nvim" })
deps.later(require("config.plugins.mason").setup)

deps.add({ source = "b0o/schemastore.nvim" })
deps.add({ source = "neovim/nvim-lspconfig", depends = { "b0o/schemastore.nvim" } })
deps.later(require("config.plugins.lsp").setup)

deps.add({ source = "L3MON4D3/LuaSnip" })
deps.add({
  source = "saghen/blink.cmp",
  depends = { "L3MON4D3/LuaSnip" },
})
deps.later(require("config.plugins.blink").setup)

deps.add({ source = "MagicDuck/grug-far.nvim" })
deps.later(function()
  require("config.plugins.grug-far").setup()
  vim.keymap.set("v", "<leader>f", ":SearchFileVisual<CR>", { desc = "Find in file (visual)" })
  vim.keymap.set("v", "<leader>r", ":SearchProjectVisual<CR>", { desc = "Find in project (visual)" })
  vim.keymap.set("n", "<C-F>", ":SearchFile<CR>", { desc = "Find in file" })
  vim.keymap.set("n", "<C-S>", ":SearchProject<CR>", { desc = "Find in project" })
end)

deps.add({ source = "ggandor/leap.nvim" })
deps.later(function()
  require("config.plugins.leap").setup()
  vim.keymap.set("n", "<leader>;", function()
    require("leap").leap({ target_windows = require("leap.user").get_focusable_windows() })
  end, { desc = "Leap" })
  vim.keymap.set("n", "s", function()
    require("leap").leap({ target_windows = require("leap.user").get_focusable_windows() })
  end, { desc = "Leap" })
  vim.keymap.set("n", "gs", function()
    require("leap.remote").action()
  end, { desc = "Leap remote" })
end)

deps.add({ source = "Wansmer/treesj" })
deps.later(function()
  require("treesj").setup({})
  vim.keymap.set("n", "<leader>tj", ":TSJJoin<CR>", { silent = true, desc = "Join TS nodes" })
  vim.keymap.set("n", "<leader>tm", ":TSJToggle<CR>", { silent = true, desc = "Toggle TS nodes" })
  vim.keymap.set("n", "<leader>ts", ":TSJSplit<CR>", { silent = true, desc = "Split TS nodes" })
end)

deps.add({ source = "sindrets/diffview.nvim" })
deps.add({ source = "NeogitOrg/neogit", depends = { "sindrets/diffview.nvim" } })
deps.later(require("config.plugins.neogit").setup)

deps.add({ source = "wurli/visimatch.nvim" })
deps.later(function()
  require("visimatch").setup({ hl_group = "WVisiMatch", chars_lower_limit = 2 })
end)

deps.add({ source = "RRethy/vim-illuminate" })
deps.later(require("config.plugins.illuminate").setup)

deps.add({ source = "kevinhwang91/promise-async" })
deps.add({ source = "kevinhwang91/nvim-ufo", depends = { "kevinhwang91/promise-async" } })
deps.later(require("config.plugins.ufo").setup)

deps.add({ source = "monaqa/dial.nvim" })
deps.later(require("config.plugins.dial").setup)

---
--- Section: Post-plugin requires
---
require("config.lastplace")
require("config.tabbar")
require("config.winbar")

---
--- Section: Autocmds
---
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("reload-file-static", { clear = true }),
  desc = "Reload buffer on focus",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor to file position in previous editing session",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd('normal! g`"zz')
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("vim-resized", { clear = true }),
  desc = "Reset buffer size on window resize",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  desc = "Highlight yanked lines",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("user-lazy-done", { clear = true }),
  desc = "Custom lazy load autocmd",
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "SuperLazy" })
    end, 200)
  end,
})

---
--- Section: Commands
---
--- @param value string
local function print_and_copy(value)
  vim.cmd("call setreg('+', '" .. vim.fn.escape(value, "'") .. "')")
  print('Copied: "' .. value .. '"')
end

vim.api.nvim_create_user_command("BufOnly", function()
  vim.cmd("%bdelete|edit #|normal`")
end, {})

vim.api.nvim_create_user_command("CopyFiletype", function()
  print_and_copy(vim.bo.filetype)
end, {})

vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  print_and_copy(vim.fn.expand("%:~p"))
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  print_and_copy(vim.fn.fnamemodify(vim.fn.expand("%"), ":~:."))
end, {})

vim.api.nvim_create_user_command("CopyHighlightGroup", function()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")

  local captures = vim.treesitter.get_captures_at_pos(0, line - 1, col - 1)
  if #captures > 0 then
    vim.notify("treesitter::")
    print_and_copy(captures[#captures].capture)
    return
  end

  local synID = vim.fn.synID(line, col, 1)
  local synName = vim.fn.synIDattr(synID, "name")
  vim.notify("OG colors::")
  print_and_copy(synName)
end, {})

vim.api.nvim_create_user_command("Datetime", function()
  local datetime = os.date("%A, %B, %d, %Y %I:%M%p")
  vim.api.nvim_put({ datetime }, "c", true, true)
end, {})

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  _G.show_diagnostics = not _G.show_diagnostics
  vim.diagnostic.enable(_G.show_diagnostics)
end, {})

vim.api.nvim_create_user_command("ToggleDiagnosticText", function()
  local config = vim.diagnostic.config()
  if config ~= nil then
    if not config.virtual_text then
      _G.show_diagnostics = true
      vim.diagnostic.enable(true)
      _G.show_diagnostics_text = true
    else
      _G.show_diagnostics_text = false
    end
    vim.diagnostic.config({ virtual_text = _G.show_diagnostics_text })
  end
end, {})

vim.api.nvim_create_user_command("ToggleDiagnosticUnderline", function()
  local config = vim.diagnostic.config()
  if config ~= nil then
    if not config.underline then
      _G.show_diagnostics = true
      vim.diagnostic.enable(true)
      _G.show_diagnostics_underline = true
    else
      _G.show_diagnostics_underline = false
    end
    vim.diagnostic.config({ underline = _G.show_diagnostics_underline })
  end
end, {})

--- @type table<string, boolean>
local excluded_filetypes = {
  ["NeogitStatus"] = true,
  ["NvimTree"] = true,
  ["grug-far"] = true,
  ["no-neck-pain"] = true,
  ["snacks_dashboard"] = true,
  ["spectre_panel"] = true,
  ["toggleterm"] = true,
}

vim.api.nvim_create_user_command("ToggleLineWrap", function()
  _G.enable_line_wrap = not _G.enable_line_wrap

  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local buf_filetype = vim.bo[buf_id].filetype

    if not excluded_filetypes[buf_filetype] then
      vim.api.nvim_set_option_value("wrap", _G.enable_line_wrap, { win = win_id })
      vim.api.nvim_set_option_value("linebreak", _G.enable_line_wrap, { win = win_id })
    end
  end
end, {})

vim.api.nvim_create_user_command("DisableLineWrap", function()
  _G.enable_line_wrap = false

  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local buf_filetype = vim.bo[buf_id].filetype

    if not excluded_filetypes[buf_filetype] then
      vim.api.nvim_set_option_value("wrap", _G.enable_line_wrap, { win = win_id })
      vim.api.nvim_set_option_value("linebreak", _G.enable_line_wrap, { win = win_id })
    end
  end
end, {})

vim.api.nvim_create_user_command("ToggleInvisibleChars", function()
  _G.show_invisible_chars = not _G.show_invisible_chars
  vim.opt.list = _G.show_invisible_chars
end, {})

vim.api.nvim_create_user_command("ToggleInlayHints", function()
  _G.show_inlay_hints = not _G.show_inlay_hints
  vim.lsp.inlay_hint.enable(_G.show_inlay_hints)
end, {})

--- @type table<string, boolean>
local is_affected_by_line_numbers = {
  ["NeogitStatus"] = true,
  ["NvimTree"] = true,
  ["grug-far"] = true,
  ["help"] = true,
  ["neo-tree"] = true,
  ["no-neck-pain"] = true,
  ["oil"] = false,
  ["qf"] = true,
  ["snacks_dashboard"] = true,
  ["spectre_panel"] = true,
  ["toggleterm"] = true,
}

local function set_line_numbers(nu, rnu)
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local filetype = vim.bo[buf_id].filetype
    if not is_affected_by_line_numbers[filetype] then
      vim.api.nvim_set_option_value("number", nu, { win = win_id })
      vim.api.nvim_set_option_value("relativenumber", rnu, { win = win_id })
    end
  end
end

vim.api.nvim_create_user_command("HideLineNumbers", function()
  set_line_numbers(false, false)
  vim.cmd("e!")
end, {})

vim.api.nvim_create_user_command("ShowLineNumbers", function()
  set_line_numbers(true, false)
  vim.cmd("e!")
end, {})

vim.api.nvim_create_user_command("ShowRelativeLineNumbers", function()
  set_line_numbers(true, true)
  vim.cmd("e!")
end, {})

vim.api.nvim_create_user_command("ToggleCursorLine", function()
  _G.show_cursorline = not _G.show_cursorline
  vim.opt.cursorline = _G.show_cursorline
end, {})

---
--- Section: Diagnostics
---
vim.diagnostic.config({
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.WARN] = "",
    },
  },
  underline = _G.show_diagnostics_underline,
  virtual_text = _G.show_diagnostics_text,
  virtual_lines = false,
})
vim.diagnostic.enable(_G.show_diagnostics)

---
--- Section: Filetypes
---
vim.filetype.add({
  extension = {
    env = "sh",
    gleam = "gleam",
    mdc = "mdc",
    mdx = "mdx",
    templ = "templ",
  },
  filename = {
    [".envrc"] = "sh",
    ["Brewfile"] = "sh",
    ["go.mod"] = "gomod",
    ["go.sum"] = "gosum",
  },
  pattern = {
    [".env%..*"] = "sh",
  },
})
