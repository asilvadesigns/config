local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
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
vim.g.maplocalleader = ","
---

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.cmd(
  "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175"
)
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] --   ||   ||  
vim.opt.pumheight = 10
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.wrap = false
vim.opt.linebreak = false
---
vim.opt.synmaxcol = 256
---
vim.opt.number = true
vim.opt.relativenumber = true
---
vim.opt.foldcolumn = "1" -- "0" to hide folds. "1" to show.
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
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
-- vim.opt.list = false
-- vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
-- vim.opt.showbreak = "↳  " -- slow on huge linebreaks for some reason
---
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0
vim.opt.smoothscroll = true
---
vim.opt.laststatus = 0
vim.opt.statusline = string.rep("—", vim.api.nvim_win_get_width(0))
-- vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
-- vim.o.statusline = ""

vim.opt.signcolumn = "yes"
-- vim.optpt.statuscolumn = "%s %r "
-- vim.opt.winbar = " "
---
vim.opt.sessionoptions = "buffers,curdir,winsize,winpos"
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

---
vim.opt.termguicolors = true
---
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono"
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_scroll_animation_length = 0.05
end

--
--
--
local set = vim.keymap.set

-- overridden by multicursor
set("n", "<esc>", ":nohl<CR>", { desc = "Clear highlight" })

set("i", "<c-l>", "<END>", { desc = "Go to end of line" })
set("i", "<c-h>", "<HOME>", { desc = "Go to start of line" })

set("n", "<ScrollWheelUp>", "<C-y>")
set("n", "<ScrollWheelDown>", "<C-e>")
set("i", "<ScrollWheelUp>", "<C-y>")
set("i", "<ScrollWheelDown>", "<C-e>")
set("v", "<ScrollWheelUp>", "<C-y>")
set("v", "<ScrollWheelDown>", "<C-e>")

set("n", "<leader>s", ":wa<CR>", { desc = "Save all" })

set("n", "<leader>wh", "<C-w>h", { desc = "Focus left window" })
set("n", "<leader>wj", "<C-w>j", { desc = "Focus bottom window" })
set("n", "<leader>wk", "<C-w>k", { desc = "Focus top window" })
set("n", "<leader>wl", "<C-w>l", { desc = "Focus right window" })

set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
set("n", "<leader>wq", "<C-w>q", { desc = "Close this window" })

set("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })

set("n", "<leader>wH", "<C-w>H", { desc = "Go to the left window" })
set("n", "<leader>wJ", "<C-w>J", { desc = "Go to the down window" })
set("n", "<leader>wK", "<C-w>K", { desc = "Go to the up window" })
set("n", "<leader>wL", "<C-w>L", { desc = "Go to the right window" })

set("n", "<leader>d", "<C-d>", { desc = "Scroll down" })
set("n", "<leader>u", "<C-u>", { desc = "Scroll up" })

set("n", "<leader>qf", function()
  if vim.bo.filetype == "NvimTree" then
    require("nvim-tree.api").tree.close()
  end

  if vim.bo.filetype == "oil" then
    require("oil").close()
  end

  vim.cmd(":wqa!<CR>")
end, {
  desc = "Save and Quit",
})

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set("n", "<", ":tabprevious<CR>", { desc = "Go to the previous tab" })
set("n", ">", ":tabnext<CR>", { desc = "Go to the next tab" })
set("n", "tl", ":tablast<CR>", { desc = "Go to the last tab" })
set("n", "tn", ":tabnew<CR>", { desc = "Create new tab" })
set("n", "to", ":tabonly<CR>", { desc = "Close other tabs" })
set("n", "tq", ":tabclose<CR>", { desc = "Close this tab" })

set("n", "<leader>1", ":tabn 1<CR>", { desc = "Go to tab 1" })
set("n", "<leader>2", ":tabn 2<CR>", { desc = "Go to tab 2" })
set("n", "<leader>3", ":tabn 3<CR>", { desc = "Go to tab 3" })
set("n", "<leader>4", ":tabn 4<CR>", { desc = "Go to tab 4" })
set("n", "<leader>5", ":tabn 5<CR>", { desc = "Go to tab 5" })
set("n", "<leader>6", ":tabn 6<CR>", { desc = "Go to tab 6" })
set("n", "<leader>7", ":tabn 7<CR>", { desc = "Go to tab 7" })
set("n", "<leader>8", ":tabn 8<CR>", { desc = "Go to tab 8" })
set("n", "<leader>9", ":tabn 9<CR>", { desc = "Go to tab 9" })

set("v", "<Tab>", ">gv", { desc = "Add indent" })
set("v", "<S-Tab>", "<gv", { desc = "Remove indent " })
-- set("v", "p", '"_dP', { desc="Paste" })

set("t", "<esc>", [[<C-\><C-n>]])
set("t", "<C-c>", [[<C-\><C-n>]])

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

--
--
--
set("n", "[d", vim.diagnostic.goto_prev, {
  desc = "Go to previous diagnostic message",
})

set("n", "]d", vim.diagnostic.goto_next, {
  desc = "Go to next diagnostic message",
})

set("n", "ge", vim.diagnostic.open_float, {
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
  underline = true,
  virtual_text = false, -- NOTE: you can toggle this with "ToggleDiagnosticText" defined in config.command.lua
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

require("config.autocmd")
require("config.command")
require("config.winbar")
-- require("config.statusline")
--

---@diagnostic disable-next-line: missing-fields
require("lazy").setup({
  spec = {
    { lazy = true, "nvim-tree/nvim-web-devicons" },
    { lazy = true, "nvim-lua/plenary.nvim" },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      config = require("config.plugins.snacks").setup,
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = { "MunifTanjim/nui.nvim" },
      config = require("config.plugins.noice").setup,
    },
    {
      "folke/todo-comments.nvim",
      cmd = { "TodoTelescope", "TodoLocList" },
      config = require("config.plugins.todos").setup,
    },
    {
      "folke/trouble.nvim",
      cmd = { "ToggleTrouble", "Trouble" },
      config = require("config.plugins.trouble").setup,
    },
    {
      "rmagatti/auto-session",
      cmd = "SessionRestore",
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
      "mvllow/modes.nvim",
      enabled = false,
      event = "VeryLazy",
      tag = "v0.2.0",
      config = require("config.plugins.modes").setup,
    },
    {
      "sphamba/smear-cursor.nvim",
      enabled = false,
      event = "VeryLazy",
      config = require("config.plugins.smear-cursor").setup,
    },
    {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = require("config.plugins.better-escape").setup,
    },
    {
      "eero-lehtinen/oklch-color-picker.nvim",
      event = "User DeferFour",
      opts = {},
    },
    {
      "mfussenegger/nvim-lint",
      cmd = { "Lint", "LintWithBiome", "LintWithEslint" },
      config = require("config.plugins.lint").setup,
    },
    {
      "stevearc/conform.nvim",
      cmd = { "Format", "FormatWithBiome", "FormatWithPrettier" },
      keys = { { "<leader>m", "<cmd>Format<cr>", desc = "Format" } },
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
      "stevearc/oil.nvim",
      event = "User DeferFour",
      config = require("config.plugins.oil").setup,
    },
    {
      "jake-stewart/multicursor.nvim",
      event = "VeryLazy",
      branch = "1.0",
      config = require("config.plugins.multicursor").setup,
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
      "akinsho/bufferline.nvim",
      event = { "TabEnter", "TabNew" },
      version = "*",
      config = require("config.plugins.bufferline").setup,
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
      "RRethy/vim-illuminate",
      enabled = false,
      event = "LspAttach",
      config = require("config.plugins.illuminate").setup,
    },
    -- {
    --   "echasnovski/mini.cursorword",
    --   event = "VeryLazy",
    --   version = "*",
    --   config = require("config.plugins.mini").setup,
    -- },
    {
      "neovim/nvim-lspconfig",
      event = "User DeferThree",
      dependencies = {
        -- "saghen/blink.cmp",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
      },
      config = require("config.plugins.lsp").setup,
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      "saghen/blink.cmp",
      version = "*",
      event = { "CmdlineEnter", "InsertEnter" },
      opts_extend = { "sources.default" },
      dependencies = "rafamadriz/friendly-snippets",
      config = require("config.plugins.blink").setup,
    },
    { lazy = true, "JoosepAlviste/nvim-ts-context-commentstring" },
    {
      "numToStr/Comment.nvim",
      keys = {
        { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
        { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
        { "gbc", desc = "Comment toggle current block" },
        { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
        { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
        { "gcc", desc = "Comment toggle current line" },
      },
      config = require("config.plugins.comment").setup,
    },
    ---
    ---
    ---
    {
      "nvim-pack/nvim-spectre",
      cmd = "Spectre",
      keys = {
        { "F", "<CMD>Spectre<CR>", desc = "Find", mode = "n" },
        { "f", ":lua require('spectre').open_visual()<CR>", desc = "Find selected", mode = "v" },
      },
      config = require("config.plugins.spectre").setup,
    },
    {
      "MagicDuck/grug-far.nvim",
      cmd = { "GrugFar", "GrugFarLocal", "GrugFarGlobal" },
      keys = {
        {
          "<C-s>",
          function()
            require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
          end,
          mode = "v",
        },
        {
          "<C-f>",
          function()
            require("grug-far").with_visual_selection()
          end,
          mode = "v",
        },
      },
      config = require("config.plugins.grug-far").setup,
    },
    ---
    ---
    ---
    {
      "johmsalas/text-case.nvim",
      enabled = false,
      dependencies = {
        {
          "nvim-telescope/telescope.nvim",
          config = function()
            require("telescope").load_extension("textcase")
          end,
        },
      },
      cmd = {
        "TextCaseOpenTelescope",
        "TextCaseOpenTelescopeQuickChange",
        "TextCaseOpenTelescopeLSPChange",
        "TextCaseStartReplacingCommand",
      },
      keys = {
        "ga", -- Default invocation prefix
        {
          "ga.",
          "<CMD>TextCaseOpenTelescope<CR>",
          mode = { "n", "x" },
          desc = "Telescope",
        },
      },
      opts = {},
    },
    {
      "nvim-telescope/telescope.nvim",
      enabled = false,
      event = "User DeferOne",
      -- cmd = { "Telescope", "CommandPalette" },
      -- keys = { "<leader>a", "<leader>e", "<leader>f", "<leader>l" },
      dependencies = {
        "natecraddock/telescope-zf-native.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      config = require("config.plugins.telescope").setup,
    },
    {
      "ibhagwan/fzf-lua",
      cmd = { "FzfLua" },
      event = "User DeferThree",
      config = require("config.plugins.fzflua").setup,
    },
    ---
    ---
    ---
    {
      "nvim-tree/nvim-tree.lua",
      event = "User DeferFour",
      config = require("config.plugins.nvim-tree").setup,
    },
    ---
    ---
    ---
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
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      config = require("config.plugins.treesitter").setup,
    },
    ---
    ---
    ---
    {
      "akinsho/git-conflict.nvim",
      event = "User DeferThree",
      version = "v2.1.0",
      cmd = {
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictChooseOurs",
        "GitConflictChooseTheirs",
        "GitConflictListQf",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
      },
      config = require("config.plugins.git-conflict").setup,
    },
    {
      "tpope/vim-fugitive",
      cmd = { "Gdiffsplit", "Git", "Gvdiffsplit" },
    },
    {
      "NeogitOrg/neogit",
      cmd = "Neogit",
      dependencies = { "sindrets/diffview.nvim" },
      config = require("config.plugins.neogit").setup,
    },
    {
      "lewis6991/gitsigns.nvim",
      cmd = { "Gitsigns" },
      keys = {
        { "]g", "<CMD>Gitsigns next_hunk<CR>", "n" },
        { "[g", "<CMD>Gitsigns prev_hunk<CR>", "n" },
        { "gp", "<CMD>Gitsigns preview_hunk<CR>", "n" },
      },
      config = require("config.plugins.gitsigns").setup,
    },
    {
      "lewis6991/satellite.nvim",
      enabled = false,
      event = "VeryLazy",
      config = require("config.plugins.satellite").setup,
    },
    ---
    ---
    ---
    {
      "mrjones2014/smart-splits.nvim",
      keys = {
        -- stylua: ignore start
        -- resize
        { "<S-Down>",          function() require("smart-splits").resize_down() end },
        { "<S-Left>",          function() require("smart-splits").resize_left() end },
        { "<S-Right>",         function() require("smart-splits").resize_right() end },
        { "<S-Up>",            function() require("smart-splits").resize_up() end },
        -- moving
        { "<C-h>",             function() require("smart-splits").move_cursor_left() end },
        { "<C-j>",             function() require("smart-splits").move_cursor_down() end },
        { "<C-k>",             function() require("smart-splits").move_cursor_up() end },
        { "<C-l>",             function() require("smart-splits").move_cursor_right() end },
        -- swapping
        { "<leader><leader>h", function() require("smart-splits").swap_buf_left() end },
        { "<leader><leader>j", function() require("smart-splits").swap_buf_down() end },
        { "<leader><leader>k", function() require("smart-splits").swap_buf_up() end },
        { "<leader><leader>l", function() require("smart-splits").swap_buf_right() end },
        -- stylua: ignore end
      },
      opts = {},
    },
    ---
    ---
    ---
    {
      "folke/which-key.nvim",
      enabled = false,
      event = "VeryLazy",
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
      opts = {
        preset = "helix",
        delay = 0,
      },
    },
    ---
    ---
    ---
    ---
    ---
    ---
    {
      "ggandor/leap.nvim",
      keys = {
        {
          "s",
          function()
            require("leap").leap({
              target_windows = require("leap.user").get_focusable_windows(),
            })
          end,
          silent = true,
        },
      },
      config = function()
        vim.cmd("hi! link LeapBackdrop NvimContainer")
        vim.cmd("hi! link LeapLabel @comment.warning")
      end,
    },
  },
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "getscriptPlugin",
        "gzip",
        "matchit",
        "matchparen",
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
    border = "rounded", -- "rounded", "single"
  },
})

vim.defer_fn(function()
  vim.api.nvim_exec_autocmds("User", { pattern = "DeferOne" })
end, 100)

vim.defer_fn(function()
  vim.api.nvim_exec_autocmds("User", { pattern = "DeferTwo" })
end, 200)

vim.defer_fn(function()
  vim.api.nvim_exec_autocmds("User", { pattern = "DeferThree" })
end, 300)

vim.defer_fn(function()
  vim.api.nvim_exec_autocmds("User", { pattern = "DeferFour" })
end, 400)
