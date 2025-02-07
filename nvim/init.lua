---@diagnostic disable: missing-fields

local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if vim.env.PROF then
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = { event = "VimEnter" },
  })
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
--
--
--
vim.g.mapleader = ","
vim.g.maplocalleader = " "
---

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.conceallevel = 0
vim.opt.cursorline = true
-- vim.cmd(
--   "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175"
-- )
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] --   ||   ||  
vim.opt.pumheight = 10
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.wrap = false
vim.opt.linebreak = false
---
vim.opt.synmaxcol = 256
---
vim.opt.number = false
vim.opt.relativenumber = false
---
vim.opt.foldcolumn = "0" -- "0" to hide folds. "1" to show.
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
---
vim.opt.diffopt = "internal,filler,closeoff,linematch:60"
---
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
---
-- vim.opt.grepformat = "%f:%l:%c:%m"
-- vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.smartcase = true
---
vim.opt.splitbelow = true
vim.opt.splitkeep = "cursor"
vim.opt.splitright = true
---
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
---
vim.cmd("set nomodeline")
---
-- vim.opt.list = true
-- vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
-- vim.opt.showbreak = "↳  " -- slow on huge linebreaks for some reason
---
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0
vim.opt.smoothscroll = true
---
vim.opt.cmdheight = 0
vim.opt.signcolumn = "yes"
---
vim.opt.sessionoptions = "buffers,curdir,help,winsize,winpos"
-- perfomance
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100

---
vim.opt.termguicolors = true
---
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

--
--
--
-- overridden by multicursor
vim.keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Clear highlight" })

vim.keymap.set("i", "<c-l>", "<END>", { desc = "Go to end of line" })
vim.keymap.set("i", "<c-h>", "<HOME>", { desc = "Go to start of line" })

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

vim.keymap.set("n", "<leader>s", function()
  vim.cmd("w")
end, { desc = "Save" })

vim.keymap.set("n", "<leader>qf", function()
  if vim.bo.filetype == "NvimTree" then
    require("nvim-tree.api").tree.close()
  end

  if vim.bo.filetype == "oil" then
    require("oil").close()
  end

  vim.cmd("qa!")
end, { desc = "Save and Quit" })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
-- vim.keymap.set("v", "p", '"_dP', { desc="Paste" })

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-c>", [[<C-\><C-n>]])

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

--
--
--
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "ge", vim.diagnostic.open_float, {
  desc = "Open diagnostic message",
})

local signs = require("config.signs")

for type, icon in pairs(signs.diagnostics) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
  })
end

vim.diagnostic.config({
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.icons.square,
      [vim.diagnostic.severity.HINT] = signs.icons.square,
      [vim.diagnostic.severity.INFO] = signs.icons.square,
      [vim.diagnostic.severity.WARN] = signs.icons.square,
    },
    -- numhl = {
    --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    --   [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    --   [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    --   [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    -- },
  },
  -- NOTE: you can toggle this with "ToggleDiagnosticText" defined in config.command.lua
  underline = true,
  virtual_text = false,
  virtual_lines = false,
})

vim.filetype.add({
  extension = {
    env = "sh",
    mdx = "mdx",
    templ = "templ",
  },
  filename = {
    [".envrc"] = "sh",
    ["go.mod"] = "gomod",
    ["go.sum"] = "gosum",
  },
  pattern = {
    [".env%..*"] = "sh",
  },
})

---
--- Autocmds
---
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

---
--- Commands
---
--- @param value string
local function print_and_copy(value)
  vim.cmd("call setreg('+', '" .. vim.fn.escape(value, "'") .. "')")
  print("Copied: " .. value)
end

vim.api.nvim_create_user_command("CopyFiletype", function()
  print_and_copy(vim.bo.filetype)
end, {})

vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  print_and_copy(vim.fn.expand("%:~p"))
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  print_and_copy(vim.fn.fnamemodify(vim.fn.expand("%"), ":~:."))
end, {})

vim.api.nvim_create_user_command("ToggleDiagnosticText", function()
  local config = vim.diagnostic.config()

  if config ~= nil then
    vim.diagnostic.config({ virtual_text = not config.virtual_text })
  end
end, {})

require("config.winbar")

---@diagnostic disable-next-line: missing-fields
require("lazy").setup({
  root = vim.fn.expand("~/dev/lazy/plugins"),
  spec = {
    { lazy = true, "nvim-tree/nvim-web-devicons", opts = { color_icons = false } },
    { lazy = true, "nvim-lua/plenary.nvim" },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      config = require("config.plugins.snacks").setup,
    },
    {
      "folke/noice.nvim",
      enabled = false,
      lazy = false,
      dependencies = { "MunifTanjim/nui.nvim" },
      config = require("config.plugins.noice").setup,
    },
    {
      "folke/todo-comments.nvim",
      cmd = { "TodoFzfLua", "TodoLocList" },
      config = require("config.plugins.todos").setup,
    },
    {
      "folke/trouble.nvim",
      cmd = { "ToggleTrouble", "Trouble" },
      config = require("config.plugins.trouble").setup,
    },
    {
      "folke/ts-comments.nvim",
      event = "VeryLazy",
      opts = {},
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      config = require("config.plugins.flash").setup,
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    {
      "rmagatti/auto-session",
      event = "VeryLazy",
      cmd = { "SessionRestore" },
      config = require("config.plugins.auto-session").setup,
    },
    {
      "catppuccin/nvim",
      priority = 1000,
      name = "catppuccin",
      config = require("config.plugins.catppuccin").setup,
    },
    {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      config = require("config.plugins.quicker").setup,
    },
    {
      "eero-lehtinen/oklch-color-picker.nvim",
      event = "VeryLazy",
      config = require("config.plugins.color-picker").setup,
    },
    {
      "mfussenegger/nvim-lint",
      cmd = { "Lint", "LintWithBiome", "LintWithEslint" },
      config = require("config.plugins.lint").setup,
    },
    {
      "stevearc/conform.nvim",
      cmd = { "Format", "FormatWithBiome", "FormatWithLsp", "FormatWithPrettier" },
      keys = { { "<leader>m", "<CMD>Format<cr>", desc = "Format" } },
      config = require("config.plugins.conform").setup,
    },
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
      ft = { "markdown" },
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
    {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = require("config.plugins.better-escape").setup,
    },
    {
      "stevearc/oil.nvim",
      event = "VeryLazy",
      config = require("config.plugins.oil").setup,
    },
    {
      "gbprod/substitute.nvim",
      keys = { { "X", "<CMD>lua require('substitute.exchange').visual()<CR>", mode = "x" } },
      opts = {},
    },
    {
      "kylechui/nvim-surround",
      keys = { { "S", mode = "v" }, { "cs" }, { "ds" }, { "ys" } },
      opts = {},
    },
    {
      "shortcuts/no-neck-pain.nvim",
      keys = { { "<leader>z", "<CMD>NoNeckPain<CR>", desc = "Toggle zen mode" } },
      version = "*",
      config = require("config.plugins.no-neck-pain").setup,
    },
    {
      "kevinhwang91/nvim-ufo",
      event = "LspAttach",
      dependencies = { "kevinhwang91/promise-async" },
      config = require("config.plugins.ufo").setup,
    },
    {
      "nvim-tree/nvim-tree.lua",
      event = "VeryLazy",
      config = require("config.plugins.nvim-tree").setup,
    },
    {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
      dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
      config = require("config.plugins.lsp").setup,
    },
    {
      "saghen/blink.cmp",
      version = "*",
      event = { "CmdlineEnter", "InsertEnter" },
      opts_extend = { "sources.default" },
      dependencies = "rafamadriz/friendly-snippets",
      config = require("config.plugins.blink").setup,
    },
    {
      "MagicDuck/grug-far.nvim",
      cmd = { "GrugFar", "GrugFarLocal", "GrugFarGlobal" },
      keys = {
        {
          "f",
          mode = "v",
          function()
            require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
          end,
          desc = "Find selected in file",
        },
        {
          "F",
          mode = "v",
          function()
            require("grug-far").with_visual_selection()
          end,
          desc = "Find selected in project",
        },
      },
      config = require("config.plugins.grug-far").setup,
    },
    {
      "Wansmer/treesj",
      keys = {
        { "<leader>tj", ":TSJJoin<CR>", silent = true, desc = "Join TS nodes" },
        { "<leader>tm", ":TSJToggle<CR>", silent = true, desc = "Toggle TS nodes" },
        { "<leader>ts", ":TSJSplit<CR>", silent = true, desc = "Split TS nodes" },
      },
      opts = {},
    },
    {
      "andymass/vim-matchup",
      enabled = false,
      event = "VeryLazy",
      init = require("config.plugins.matchup").init,
      config = require("config.plugins.matchup").setup,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "andymass/vim-matchup" },
      config = require("config.plugins.treesitter").setup,
    },
    ---
    --- GIT
    {
      "NeogitOrg/neogit",
      event = "VeryLazy",
      dependencies = { "sindrets/diffview.nvim" },
      config = require("config.plugins.neogit").setup,
    },
    {
      "akinsho/git-conflict.nvim",
      event = "VeryLazy",
      version = "v2.1.0",
      config = require("config.plugins.git-conflict").setup,
    },
    {
      "tpope/vim-fugitive",
      event = "VeryLazy",
      cmd = { "Gdiffsplit", "Git", "Gvdiffsplit" },
    },
    {
      "mrjones2014/smart-splits.nvim",
      event = "VeryLazy",
      config = require("config.plugins.smart-splits").setup,
    },
    ---
    --- UI
    {
      "jake-stewart/multicursor.nvim",
      event = "VeryLazy",
      branch = "1.0",
      config = require("config.plugins.multicursor").setup,
    },
    {
      "wurli/visimatch.nvim",
      event = "VeryLazy",
      opts = { hl_group = "WVisiMatch", chars_lower_limit = 3 },
    },
    {
      "akinsho/bufferline.nvim",
      event = { "TabEnter", "TabNew" },
      version = "*",
      config = require("config.plugins.bufferline").setup,
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "getscriptPlugin",
        "gzip",
        "matchit",
        "matchparen",
        "editorconfig",
        "netrwPlugin",
        "osc52",
        "remotePlugin",
        "rplugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimballPlugin",
        "zipPlugin",
      },
    },
  },
  ui = {
    backdrop = 100,
    border = "rounded",
  },
})
