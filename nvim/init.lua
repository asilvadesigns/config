--
--
--
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
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.pumheight = 10
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
---
vim.opt.number = true
vim.opt.relativenumber = true
---
vim.opt.foldcolumn = "1" -- "0" to hide folds. "1" to show.
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
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
vim.opt.list = false
vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.opt.showbreak = "↳  "
---
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0
vim.opt.smoothscroll = true
---
vim.opt.laststatus = 0
vim.opt.statusline = string.rep("—", vim.api.nvim_win_get_width(0))

vim.opt.signcolumn = "yes"
vim.cmd("set cmdheight=0")
-- vim.optpt.statuscolumn = "%s %r "
vim.opt.winbar = " "
---
vim.opt.sessionoptions = "buffers,curdir,winsize,winpos"
---
vim.opt.termguicolors = true
---
vim.opt.linebreak = true
vim.opt.wrap = false

--
--
--
local set = vim.keymap.set

set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlight" })
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
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    },
  },
  underline = true,
  virtual_text = false,
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

require("lazy").setup({
  spec = {
    { lazy = true, "nvim-tree/nvim-web-devicons" },
    {
      "willothy/veil.nvim",
      lazy = false,
      config = require("config.plugins.veil").setup,
    },
    {
      "rmagatti/auto-session",
      cmd = "SessionRestore",
      config = require("config.plugins.auto-session").setup,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = require("config.plugins.catppuccin").setup,
    },
    {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      config = require("config.plugins.quicker").setup,
    },
    {
      "mvllow/modes.nvim",
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
      "brenoprata10/nvim-highlight-colors",
      cmd = { "HighlightColors" },
      opts = {},
    },
    {
      "mfussenegger/nvim-lint",
      cmd = { "Lint", "LintWithBiome", "LintWithEslint" },
      config = require("config.plugins.lint").setup,
    },
    {
      "stevearc/conform.nvim",
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
      event = "VeryLazy",
      cmd = { "Oil" },
      keys = { { "<leader>x", "<CMD>Oil<CR>", desc = "Show oil" } },
      config = require("config.plugins.oil").setup,
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
      "mg979/vim-visual-multi",
      event = "ModeChanged",
      config = require("config.plugins.vim-visual-multi").setup,
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
      cmd = { "NoNeckPain", "NoNeckPainWidthDown", "NoNeckPainWidthUp" },
      keys = { { "<leader>z", "<CMD>NoNeckPain<CR>", desc = "Toggle zen mode" } },
      version = "*",
      config = require("config.plugins.no-neck-pain").setup,
    },
    ---
    ---
    ---
    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
        "saadparwaiz1/cmp_luasnip",
      },
      config = require("config.plugins.cmp").setup,
    },
    {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
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
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      --- TODO: soon
      "saghen/blink.cmp",
      enabled = false,
      version = "v0.*",
      event = "InsertEnter",
      dependencies = {
        "L3MON4D3/LuaSnip",
      },
      opts_extend = { "sources.completion.enabled_providers" },
      config = require("config.plugins.blink").setup,
    },
    ---
    ---
    ---
    {
      dir = "~/.config/nvim/colors",
      enabled = false,
      name = "minimal",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme("minimal")
        vim.cmd("hi! link NvimTreeNormal Normal")
      end,
    },
    {
      "projekt0n/github-nvim-theme",
      enabled = false,
      name = "github-theme",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require("github-theme").setup()

        vim.cmd("colorscheme github_dark")
        -- vim.cmd("colorscheme github_light")

        vim.cmd("hi! link CursorLineFold CursorLine")
        vim.cmd("hi! link CursorLineNr CursorLine")
        vim.cmd("hi! link CursorLineSign CursorLine")

        vim.cmd("hi! link StatusLine Normal")
        vim.cmd("hi! link StatusLineNC Normal")

        vim.cmd("hi! link WinSeparator LineNr")
        vim.cmd("hi! link Winbar Normal")
        vim.cmd("hi! link WinbarNC Normal")

        vim.cmd("hi! link WinbarNC Normal")

        vim.cmd("hi! link NvimTreeFileIcon NvimTreeFolderIcon")
        vim.cmd("hi! link NvimTreeIndentMarker WinSeparator")
        vim.cmd("hi! link NvimTreeNormal Normal")

        vim.cmd("hi! link LazyNormal Normal")

        local c = require("github-theme.palette").load("github_dark")
        vim.print(vim.inspect(c))
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.blue.base })
      end,
    },
    ---
    ---
    ---
    { lazy = true, "MunifTanjim/nui.nvim" },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      config = require("config.plugins.noice").setup,
    },
    ---
    ---
    ---
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
    ---
    ---
    ---
    {
      "nvim-pack/nvim-spectre",
      cmd = "Spectre",
      keys = {
        {
          "<C-s>",
          "<cmd>Spectre<cr>",
          desc = "Search",
        },
        {
          "<C-f>",
          ":lua require('spectre').open_visual()<CR>",
          desc = "Replace current word (Root dir)",
          mode = "v",
        },
      },
      config = require("config.plugins.spectre").setup,
    },
    {
      "MagicDuck/grug-far.nvim",
      keys = {
        {
          "f",
          function()
            require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
          end,
          mode = "v",
        },
        {
          "F",
          function()
            require("grug-far").with_visual_selection()
          end,
          mode = "v",
        },
      },
      cmd = {
        "GrugFar",
        "GrugFarLocal",
        "GrugFarGlobal",
      },
      config = require("config.plugins.grug-far").setup,
    },
    ---
    ---
    ---
    ---
    ---
    ---
    {
      "johmsalas/text-case.nvim",
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
          "<cmd>TextCaseOpenTelescope<CR>",
          mode = { "n", "x" },
          desc = "Telescope",
        },
      },
      opts = {},
    },
    {
      "nvim-telescope/telescope.nvim",
      event = "VeryLazy",
      cmd = { "Telescope", "CommandPalette" },
      keys = {
        "<leader>a",
        "<leader>e",
        "<leader>f",
        "<leader>l",
      },
      dependencies = {
        "natecraddock/telescope-zf-native.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      config = require("config.plugins.telescope").setup,
    },
    {
      enabled = false,
      "ibhagwan/fzf-lua",
      cmd = { "FzfLua" },
      keys = {
        {
          "<leader>a",
          function()
            ---@class Entry
            ---@field cmd string | fun(): nil
            ---@type table<string, Entry>
            local commands = {
              ["Commands"] = { cmd = "FzfLua commands" },
              ["Copy file path (Absolute)"] = { cmd = "CopyAbsolutePath" },
              ["Copy file path (Relative)"] = { cmd = "CopyRelativePath" },
              ["Copy filetype"] = { cmd = "CopyFiletype" },
              ["Diagnostics"] = { cmd = "Telescope diagnostics_document" },
              ["Find Lines"] = { cmd = "FzfLua blines" },
              ["Find Word"] = { cmd = "FzfLua grep_project" },
              ["Format (Biome)"] = { cmd = "FormatWithBiome" },
              ["Format (Prettier)"] = { cmd = "FormatWithPrettier" },
              ["Format (default)"] = { cmd = "Format" },
              ["Git (Fugitive)"] = { cmd = "Git" },
              ["Git (Neogit)"] = { cmd = "Neogit" },
              ["Help"] = { cmd = "FzfLua helptags" },
              ["Highlights"] = { cmd = "FzfLua highlights" },
              ["Keymaps"] = { cmd = "FzfLua keymaps" },
              ["Lazy"] = { cmd = "Lazy" },
              ["Lint (Biome)"] = { cmd = "LintWithBiome" },
              ["Lint (EsLint)"] = { cmd = "LintWithPrettier" },
              ["Lint (default)"] = { cmd = "Lint" },
              ["Load Session"] = { cmd = "LoadSession" },
              ["Mason"] = { cmd = "Mason" },
              ["Markdown Preview"] = { cmd = "MarkdownPreviewToggle" },
              ["Noice dismiss"] = { cmd = "Noice dismiss" },
              ["Noice messages"] = { cmd = "Noice fzf" },
              ["Open (Finder)"] = { cmd = "!open ." },
              ["Quit force"] = { cmd = "qa!" },
              ["Rename File"] = { cmd = "RenameFile" },
              ["Restart LSP"] = { cmd = "LspRestart" },
              ["Save"] = { cmd = "wa" },
              ["Save and quit force"] = { cmd = "wqa!" },
              ["Search"] = { cmd = "Spectre" },
              ["Search (local)"] = { cmd = "GrugFarLocal" },
              ["Search (global)"] = { cmd = "GrugFarGlobal" },
              ["Symbols"] = { cmd = "FzfLua lsp_document_symbols" },
              ["Symbols (Workspace)"] = { cmd = "FzfLua lsp_workspace_symbols" },
              ["Buf Only"] = { cmd = "only|bd|e#" },
              ["Tab Close"] = { cmd = "tabclose" },
              ["Tab New"] = { cmd = "tabnew" },
              ["Tab Next"] = { cmd = "tabnext" },
              ["Tab Only"] = { cmd = "tabonly" },
              ["Tab Previous"] = { cmd = "tabprevious" },
              ["Todos Quickfix"] = { cmd = "TodoLocList" },
              ["Trouble"] = { cmd = "Trouble" },
              ["Zen Mode (no neck pain)"] = { cmd = "NoNeckPain" },
              ["Zen Mode (decrease)"] = { cmd = "NoNeckPainWidthDown" },
              ["Zen Mode (increase)"] = { cmd = "NoNeckPainWidthUp" },
            }

            local keys = {}
            local n = 0
            for k, _ in pairs(commands) do
              n = n + 1
              keys[n] = k
            end

            require("fzf-lua").fzf_exec(keys, {
              actions = {
                ["enter"] = function(selected)
                  if selected and selected[1] then
                    local meta = commands[selected[1]]

                    if type(meta.cmd) == "function" then
                      meta.cmd()
                    elseif type(meta.cmd) == "string" then
                      vim.cmd(meta.cmd)
                    end
                  end
                end,
              },
            })
          end,
        },
        {
          "<leader>b",
          function()
            require("fzf-lua").buffers()
          end,
        },
        {
          "<leader>e",
          function()
            require("fzf-lua").oldfiles()
          end,
        },
        {
          "<leader>f",
          function()
            require("fzf-lua").files()
          end,
        },
        {
          "<leader>l",
          function()
            require("fzf-lua").blines()
          end,
        },
      },
      config = require("config.plugins.fzflua").setup,
    },
    ---
    ---
    ---
    {
      "nvim-tree/nvim-tree.lua",
      event = "VeryLazy",
      keys = {
        {
          "<leader>j",
          function()
            if vim.bo.filetype == "NvimTree" then
              vim.cmd("NvimTreeClose")
            else
              vim.cmd("NvimTreeFindFile")
            end
          end,
          desc = "Toggle file tree",
        },
      },
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
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      config = require("config.plugins.treesitter").setup,
    },
    ---
    ---
    ---
    {
      "kevinhwang91/nvim-ufo",
      event = "VeryLazy",
      dependencies = {
        "kevinhwang91/promise-async",
        {
          "luukvbaal/statuscol.nvim",
          opts = function()
            local builtin = require("statuscol.builtin")

            return {
              relculright = true,
              ft_ignore = { "NvimTree", "dashboard" },
              segments = {
                {
                  sign = {
                    namespace = { "gitsigns" },
                    fillchar = " ",-- │
                    maxwidth = 1,
                    colwidth = 1,
                    wrap = true,
                    foldclosed = true,
                  },
                  click = "v:lua.ScSa",
                },
                { text = { " ", builtin.lnumfunc }, click = "v:lua.ScLa" },
                { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
              },
            }
          end,
        },
      },
      config = require("config.plugins.ufo").setup,
    },
    ---
    --- Plugins::Source Control
    ---
    {
      "akinsho/git-conflict.nvim",
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
        { "gj", "<CMD>Gitsigns next_hunk<CR>", "n" },
        { "gk", "<CMD>Gitsigns prev_hunk<CR>", "n" },
        { "gp", "<CMD>Gitsigns preview_hunk<CR>", "n" },
      },
      config = require("config.plugins.gitsigns").setup,
    },
    ---
    ---
    ---
    {
      "mrjones2014/smart-splits.nvim",
      keys = {
      -- stylua: ignore start
      -- resize
      { "<S-Down>", function() require("smart-splits").resize_down() end },
      { "<S-Left>", function() require("smart-splits").resize_left() end },
      { "<S-Right>", function() require("smart-splits").resize_right() end },
      { "<S-Up>", function() require("smart-splits").resize_up() end },
      -- moving
      { "<C-h>", function() require("smart-splits").move_cursor_left() end },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end },
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
    ---
    ---
    ---
    ---
    ---
    ---
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
    ---
    ---
    ---
    {
      "ggandor/leap.nvim",
      keys = {
        {
          ";",
          mode = { "n" },
          function()
            require("leap").leap({
              labels = "sfnjklhodweimbuyvrgtaqpcxz",
              target_windows = { vim.api.nvim_get_current_win() },
            })
          end,
        },
      },
      config = function()
        vim.cmd("hi! link LeapBackdrop NvimContainer")
        -- vim.cmd("hi! link LeapLabel @text.note")
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

vim.cmd("hi! link StatusLine WinSeparator")
vim.cmd("hi! link StatusLineNC WinSeparator")
