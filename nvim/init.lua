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
vim.o.background = "dark"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.conceallevel = 0
vim.o.cursorline = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.pumheight = 10
vim.o.swapfile = false
vim.o.writebackup = false
---
vim.o.number = true
vim.o.relativenumber = true
---
vim.o.foldcolumn = "0" -- "0" to hide folds. "1" to show.
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "indent"
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
---
vim.o.splitbelow = true
vim.o.splitkeep = "cursor"
vim.o.splitright = true
---
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
---
vim.o.list = false
vim.o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.o.showbreak = "↳  "
---
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0
vim.opt.smoothscroll = true
---
vim.opt.laststatus = 3
-- local str = string.rep("—", 500)
-- vim.opt.statusline = str
vim.opt.signcolumn = "yes"
-- vim.opt.winbar = " "
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
---Create an autocmd to launch a file browser plugin when opening dirs.
---@param plugin_name string
---@param plugin_open fun(path: string) Function to open the file browser
local function attach_file_browser(plugin_name, plugin_open)
  local previous_buffer_name
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("CustomAutocmdGroupName", { clear = true }),
    desc = string.format("[%s] replacement for Netrw", plugin_name),
    pattern = "*",
    callback = function()
      vim.schedule(function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if vim.fn.isdirectory(buffer_name) == 0 then
          _, previous_buffer_name = pcall(vim.fn.expand, "#:p:h")
          return
        end

        -- Avoid reopening when exiting without selecting a file
        if previous_buffer_name == buffer_name then
          previous_buffer_name = nil
          return
        else
          previous_buffer_name = buffer_name
        end

        -- Ensure no buffers remain with the directory name
        vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })
        plugin_open(vim.fn.expand("%:p:h"))
      end)
    end,
  })
end

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
      config = function()
        require("modes").setup()
      end,
    },
    ---
    ---
    ---
    {
      "echasnovski/mini.cursorword",
      event = "VeryLazy",
      version = "*",
      config = function()
        require("mini.cursorword").setup({
          delay = 25,
        })

        vim.cmd("hi! link MiniCursorword CursorLine")
        vim.cmd("hi! link MiniCursorwordCurrent CursorLine")
      end,
    },
    ---
    ---
    ---
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
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      enabled = false,
      opts = {
        dashboard = {
          enabled = true,
          sections = {
            { section = "keys", gap = 1, padding = 1 },
            { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          },
        },
        bigfile = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      },
    },
    {
      "folke/persistence.nvim",
      event = "VeryLazy", -- this will only start session saving when an actual file was opened
      config = function()
        require("persistence").setup()

        vim.api.nvim_create_user_command("LoadSession", function()
          require("persistence").load()
        end, {})

        vim.api.nvim_create_user_command("SelectSession", function()
          require("persistence").select()
        end, {})

        vim.api.nvim_create_user_command("LoadLastSession", function()
          require("persistence").load({ last = true })
        end, {})

        vim.api.nvim_create_user_command("StopSession", function()
          require("persistence").stop()
        end, {})
      end,
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
    { lazy = true, "hrsh7th/cmp-nvim-lsp" },
    { lazy = true, "williamboman/mason-lspconfig.nvim" },
    { lazy = true, "williamboman/mason.nvim" },
    {
      "neovim/nvim-lspconfig",
      event = { "VeryLazy" },
      config = require("config.plugins.lsp").setup,
    },
    ---
    ---
    ---
    { lazy = true, "Bilal2453/luvit-meta" },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    ---
    ---
    ---
    {
      "EdenEast/nightfox.nvim",
      lazy = false,
      enabled = false,
      name = "nightfox",
      priority = 1000,
      config = function()
        vim.cmd("colorscheme nordfox")
      end,
    },
    {
      "catppuccin/nvim",
      lazy = false,
      name = "catppuccin",
      priority = 1000,
      config = require("config.plugins.catppuccin").setup,
    },
    {
      "folke/noice.nvim",
      lazy = false,
      -- event = "VeryLazy",
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
      lazy = true,
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
    {
      lazy = true,
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      keys = {
        "<leader>a",
        "<leader>e",
        "<leader>f",
        "<leader>l",
      },
      config = require("config.plugins.telescope").setup,
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
      init = function()
        local oil_open_folder = function(path)
          require("oil").open(path)
        end
        attach_file_browser("oil", oil_open_folder)
      end,
      config = require("config.plugins.oil").setup,
    },
    {
      "nvim-tree/nvim-tree.lua",
      keys = {
        {
          "<leader>j",
          function()
            local filetype = vim.bo.filetype

            if filetype == "NvimTree" then
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
      event = { "BufReadPre", "BufNewFile" },
      build = ":TSUpdate",
      -- init = function(plugin)
      --   require("lazy.core.loader").add_to_rtp(plugin)
      --   require("nvim-treesitter.query_predicates")
      -- end,
      config = require("config.plugins.treesitter").setup,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = { "VeryLazy" },
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
          textobjects = {
            move = {
              enable = true,
              set_jumps = true,
              goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "Previous function" },
                ["[c"] = { query = "@class.outer", desc = "Previous class" },
                ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
              },
              goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "Next function" },
                ["]c"] = { query = "@class.outer", desc = "Next class" },
                ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
              },
            },
            select = {
              enable = true,
              lookahead = true,
              include_surrounding_whitespace = false,
              keymaps = {
                ["af"] = { query = "@function.outer" },
                ["if"] = { query = "@function.inner" },
                ["ac"] = { query = "@class.outer" },
                ["ic"] = { query = "@class.inner" },
                ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
                ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
                ["al"] = { query = "@loop.outer", desc = "around a loop" },
                ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
                ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
                ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
              },
            },
          },
        })
      end,
    },
    ---
    ---
    ---
    {
      "kevinhwang91/nvim-ufo",
      event = { "VeryLazy" },
      -- lazy = false,
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
    ---
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
      dependencies = { "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
      config = require("config.plugins.neogit").setup,
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
  },
  install = {
    colorscheme = { "catppucin-frappe" },
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
})
