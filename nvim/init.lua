--
--
-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
-- User Options
vim.g.mapleader = ","
vim.g.maplocalleader = ","
---
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.pumheight = 10
vim.opt.swapfile = false
vim.opt.writebackup = false
---
vim.opt.number = true
vim.opt.relativenumber = true
---
vim.opt.foldcolumn = "0" -- "0" to hide folds. "1" to show.
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = "indent"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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
vim.cmd("set laststatus=0")
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
-- User Keymaps
local opts = {
  noremap = true,
  silent = true,
}
--
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlight" })
--
vim.keymap.set("i", "<c-l>", "<END>", opts)
vim.keymap.set("i", "<c-h>", "<HOME>", opts)
--
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>", opts)
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>", opts)
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>", opts)
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>", opts)
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>", opts)
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>", opts)
--
vim.keymap.set("n", "<leader>s", ":wa<CR>", opts)
vim.keymap.set("n", "<leader>wh", "<C-w>h", opts)
vim.keymap.set("n", "<leader>wj", "<C-w>j", opts)
vim.keymap.set("n", "<leader>wk", "<C-w>k", opts)
vim.keymap.set("n", "<leader>wl", "<C-w>l", opts)
vim.keymap.set("n", "<leader>wo", "<C-w>o", opts)
vim.keymap.set("n", "<leader>wq", "<C-w>q", opts)
vim.keymap.set("n", "<leader>w=", "<C-w>=", opts)
vim.keymap.set("n", "<leader>ws", "<C-w>s", opts)
vim.keymap.set("n", "<leader>wv", "<C-w>v", opts)
vim.keymap.set("n", "<leader>wH", "<C-w>H", opts)
vim.keymap.set("n", "<leader>wJ", "<C-w>J", opts)
vim.keymap.set("n", "<leader>wK", "<C-w>K", opts)
vim.keymap.set("n", "<leader>wL", "<C-w>L", opts)
vim.keymap.set("n", "<leader>d", "<C-d>", opts)
vim.keymap.set("n", "<leader>u", "<C-u>", opts)
--
vim.keymap.set("n", "<leader>qf", function()
  if vim.bo.filetype == "NvimTree" then
    require("nvim-tree.api").tree.close()
  end

  if vim.bo.filetype == "oil" then
    require("oil").close()
  end

  vim.cmd(":wqa!<CR>")
end, opts)
--
vim.keymap.set("n", "<", ":tabprevious<CR>", opts)
vim.keymap.set("n", ">", ":tabnext<CR>", opts)
vim.keymap.set("n", "tl", ":tablast<CR>", opts)
vim.keymap.set("n", "tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "to", ":tabonly<CR>", opts)
vim.keymap.set("n", "tq", ":tabclose<CR>", opts)
vim.keymap.set("n", "<leader>1", ":tabn 1<CR>", opts)
vim.keymap.set("n", "<leader>2", ":tabn 2<CR>", opts)
vim.keymap.set("n", "<leader>3", ":tabn 3<CR>", opts)
vim.keymap.set("n", "<leader>4", ":tabn 4<CR>", opts)
vim.keymap.set("n", "<leader>5", ":tabn 5<CR>", opts)
vim.keymap.set("n", "<leader>6", ":tabn 6<CR>", opts)
vim.keymap.set("n", "<leader>7", ":tabn 7<CR>", opts)
vim.keymap.set("n", "<leader>8", ":tabn 8<CR>", opts)
vim.keymap.set("n", "<leader>9", ":tabn 9<CR>", opts)
--
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)
-- vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
-- vim.keymap.set("v", "j", "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)
--
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts)
--
vim.keymap.set("v", "p", '"_dP', opts)
--
vim.keymap.set("n", "<C-S-H>", ":vertical resize +3<CR>", opts)
vim.keymap.set("n", "<C-S-L>", ":vertical resize -3<CR>", opts)
vim.keymap.set("n", "<C-S-J>", ":resize +3<CR>", opts)
vim.keymap.set("n", "<C-S-K>", ":resize -3<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", opts)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", opts)
--
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
-- User Diagnostics
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
vim.diagnostic.config({
  float = { border = "rounded" },
})

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "ge", vim.diagnostic.open_float, {
  desc = "Open diagnostic message",
})

local square = vim.fn.nr2char(0x25aa)

local signs = {
  Error = square,
  Warn = square,
  Hint = square,
  Info = square,
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
  })
end

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = square,
      [vim.diagnostic.severity.HINT] = square,
      [vim.diagnostic.severity.INFO] = square,
      [vim.diagnostic.severity.WARN] = square,
    },
    -- NOTE: cool to highlight but too much.
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    },
  },
})

---
---
---
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
---
---
require("config.autocmd")
require("config.command")
require("config.winbar")

---
---
---
require("lazy").setup({
  spec = {
    { lazy = true, "MunifTanjim/nui.nvim" },
    { lazy = true, "nvim-lua/plenary.nvim" },
    { lazy = true, "nvim-tree/nvim-web-devicons" },
    ---
    ---
    ---
    {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      ---@module "quicker"
      ---@type quicker.SetupOptions
      opts = {},
    },
    ---
    ---
    ---
    {
      "mvllow/modes.nvim",
      event = "VeryLazy",
      tag = "v0.2.0",
      onfig = function()
        require("modes").setup({
          ignore_filetypes = {
            "NvimTree",
            "TelescopePrompt",
          },
        })
      end,
    },
    ---
    ---
    ---
    {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      opts = {
        default_mappings = false,
        mappings = {
          i = {
            k = { j = "<Esc>" },
          },
        },
      },
    },
    ---
    ---
    ---
    {
      "echasnovski/mini.cursorword",
      event = "VeryLazy",
      version = "*",
      config = function()
        _G.cursorword_blocklist = function()
          if vim.bo.filetype == "NvimTree" then
            vim.b.minicursorword_disable = true
          else
            vim.b.minicursorword_disable = false
          end
        end

        vim.cmd("au CursorMoved * lua _G.cursorword_blocklist()")

        require("mini.cursorword").setup({
          delay = 25,
        })

        vim.api.nvim_set_hl(0, "MiniCursorword", {
          bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
          italic = false,
          underline = false,
        })

        vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {
          bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticVirtualTextInfo"), "bg"),
          italic = false,
          underline = false,
        })
      end,
    },
    ---
    ---
    ---
    {
      "dstein64/nvim-scrollview",
      enabled = false,
      event = "VeryLazy",
      config = require("config.plugins.scrollview").setup,
    },
    {
      "petertriho/nvim-scrollbar",
      event = "VeryLazy",
      enabled = false,
      config = function()
        require("scrollbar").setup()
      end,
    },
    ---
    ---
    ---
    {
      "axelvc/template-string.nvim",
      enabled = false,
      event = "InsertEnter",
      opts = { remove_template_string = true },
    },
    {
      "windwp/nvim-autopairs",
      enabled = false,
      event = "InsertEnter",
      opts = {},
    },
    {
      "windwp/nvim-ts-autotag",
      enabled = false,
      event = "InsertEnter",
      opts = {},
    },
    ---
    ---
    ---
    ---
    {
      "nvimdev/dashboard-nvim",
      -- event = "VimEnter",
      lazy = false,
      enabled = true,
      config = function()
        require("dashboard").setup({
          theme = "doom",
          config = {
            center = {
              { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
              { icon = " ", key = "e", desc = "Recent Files", action = ":Telescope oldfiles" },
              { icon = " ", key = "s", desc = "Load Session", action = ":SessionRestore" },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
          },
        })
      end,
    },
    ---
    ---
    ---
    {
      "rmagatti/auto-session",
      -- event = "VeryLazy",
      -- lazy = false,
      cmd = { "SessionRestore" },
      opts = {
        auto_session_enabled = true,
        auto_session_create_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = false,
        session_lens = { load_on_setup = false },
        save_all_autocmds = false,
        save_cursorline = false,
        save_buffers = false,
        save_folds = false,
        save_tabs = false,
        save_terminal_session = false,
        save_file_history = false,
        save_registers = false,
        save_jumplist = false,
        save_marks = false,
        save_globals = false,
        save_options = false,
      },
    },
    ---
    ---
    ---
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
      },
      event = "InsertEnter",
      config = require("config.plugins.cmp").setup,
    },
    ---
    ---
    ---
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
      },
      event = "VeryLazy",
      config = require("config.plugins.lsp").setup,
    },
    ---
    ---
    ---
    {
      "folke/lazydev.nvim",
      dependencies = {
        "Bilal2453/luvit-meta",
      },
      -- ft = "lua",
      event = "VeryLazy",
      opts = {
        library = {
          {
            path = "luvit-meta/library",
            words = { "vim%.uv" },
          },
        },
      },
    },
    ---
    ---
    ---
    {
      "olimorris/onedarkpro.nvim",
      lazy = false,
      enabled = false,
      -- name = "onedarkpro",
      priority = 1000,
      config = function()
        require("onedarkpro").setup({})
        vim.cmd("colorscheme onedark")
      end,
    },
    {
      dir = "~/.config/nvim/colors",
      name = "minimal",
      lazy = false,
      enabled = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme("minimal")

        vim.cmd("hi! link NvimTreeNormal Normal")
      end,
    },
    {
      "navarasu/onedark.nvim",
      lazy = false,
      enabled = false,
      name = "onedark",
      priority = 1000,
      config = function()
        require("onedark").setup({ style = "light" })
        require("onedark").load()
      end,
    },
    {
      "catppuccin/nvim",
      lazy = false,
      enabled = true,
      name = "catppuccin",
      priority = 1000,
      config = require("config.plugins.catppuccin").setup,
    },
    {
      "projekt0n/github-nvim-theme",
      name = "github-theme",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      enabled = false,
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
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      config = require("config.plugins.noice").setup,
    },
    ---
    ---
    ---
    {
      lazy = true,
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    {
      "numToStr/Comment.nvim",
      keys = {
        { "gcc", mode = "n", desc = "Comment toggle current line" },
        { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
        { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
        { "gbc", mode = "n", desc = "Comment toggle current block" },
        { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
        { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
      },
      config = require("config.plugins.comment").setup,
    },
    ---
    ---
    ---
    {
      "brenoprata10/nvim-highlight-colors",
      event = "VeryLazy",
      cmd = { "HighlightColors" },
      opts = {},
    },
    ---
    ---
    ---
    {
      "nvim-pack/nvim-spectre",
      cmd = { "Spectre" },
      keys = {
        { "<C-s>", "<cmd>Spectre<cr>", desc = "Search" },
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
        "GrugFarLocal",
        "GrugFarGlobal",
      },
      config = require("config.plugins.grug-far").setup,
    },
    ---
    ---
    ---
    {
      "mfussenegger/nvim-lint",
      cmd = {
        "Lint",
        "LintWithBiome",
        "LintWithEslint",
      },
      config = require("config.plugins.lint").setup,
    },
    {
      "stevearc/conform.nvim",
      keys = {
        { "<leader>m", "<cmd>Format<cr>", mode = "n" },
      },
      config = require("config.plugins.conform").setup,
    },
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
      dependencies = {
        "natecraddock/telescope-zf-native.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      cmd = { "Telescope" },
      keys = {
        "<leader>a",
        "<leader>e",
        "<leader>f",
        "<leader>l",
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
      "stevearc/oil.nvim",
      cmd = { "Oil" },
      keys = {
        { "<leader>x", "<CMD>Oil<CR>" },
      },
      config = require("config.plugins.oil").setup,
    },
    ---
    ---
    ---
    {
      "b0o/incline.nvim",
      event = "VeryLazy",
      enabled = false,
      config = require("config.plugins.incline").setup,
    },
    ---
    ---
    ---
    {
      "nvim-tree/nvim-tree.lua",
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
          mode = "n",
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
        { "<leader>tj", mode = "n", ":TSJJoin<CR>", silent = true },
        { "<leader>tm", mode = "n", ":TSJToggle<CR>", silent = true },
        { "<leader>ts", mode = "n", ":TSJSplit<CR>", silent = true },
      },
      opts = {},
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
      build = ":TSUpdate",
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
      lazy = false,
      enabled = false,
      dependencies = {
        "kevinhwang91/promise-async",
        {
          "luukvbaal/statuscol.nvim",
          opts = function()
            local builtin = require("statuscol.builtin")

            return {
              relculright = true,
              ft_ignore = { "NvimTree" },
              segments = {
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
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "sindrets/diffview.nvim",
      },
      config = require("config.plugins.neogit").setup,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      opts = {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        current_line_blame_opts = {
          ignore_whitespace = true,
        },
      },
    },
    ---
    ---
    ---
    {
      "gbprod/substitute.nvim",
      keys = {
        {
          "X",
          function()
            require("substitute.exchange").visual()
          end,
          mode = "x",
        },
      },
      opts = {},
    },
    {
      "kylechui/nvim-surround",
      keys = {
        { "S", mode = "v" },
        { "cs", mode = "n" },
        { "ds", mode = "n" },
        { "ys", mode = "n" },
      },
      opts = {},
    },
    ---
    ---
    ---
    {
      "mg979/vim-visual-multi",
      event = "VeryLazy",
      config = function()
        vim.g.VM_theme = "iceblue"
        vim.g.VM_default_mappings = 1
        vim.g.VM_mouse_mappings = 0
        vim.g.VM_set_statusline = 0
        vim.g.VM_show_warnings = 0
        vim.g.VM_silent_exit = 1

        vim.keymap.set("x", "A", "<Plug>(VM-Visual-Cursors)", {})
      end,
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
    {
      "folke/todo-comments.nvim",
      cmd = {
        "TodoTelescope",
        "TodoLocList",
      },
      config = require("config.plugins.todos").setup,
    },
    ---
    ---
    ---
    {
      "iamcco/markdown-preview.nvim",
      cmd = {
        "MarkdownPreview",
        "MarkdownPreviewStop",
        "MarkdownPreviewToggle",
      },
      ft = { "markdown" },
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
    ---
    ---
    ---
    {
      "folke/trouble.nvim",
      cmd = {
        "ToggleTrouble",
        "Trouble",
      },
      config = require("config.plugins.trouble").setup,
    },
    ---
    ---
    ---
    {
      "shortcuts/no-neck-pain.nvim",
      enabled = true,
      cmd = { "NoNeckPain", "NoNeckPainWidthDown", "NoNeckPainWidthUp" },
      keys = {
        { "<leader>z", "<CMD>NoNeckPain<CR>", mode = "n" },
      },
      version = "*",
      config = require("config.plugins.no-neck-pain").setup,
    },
    ---
    ---
    ---
    {
      "akinsho/bufferline.nvim",
      event = "VeryLazy",
      enabled = true,
      version = "*",
      config = require("config.plugins.bufferline").setup,
    },
  },
  install = {
    colorscheme = { "catppucin-frappe" },
  },
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "editorconfig",
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
