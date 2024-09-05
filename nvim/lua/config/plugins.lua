vim.cmd("hi! link LazyNormal Normal")

require("lazy").setup({
  ---might delete forever.
  {
    "andymass/vim-matchup",
    enabled = false,
    event = "BufReadPost",
    config = require("config.plugins.matchup").setup,
  },
  {
    "RRethy/vim-illuminate",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        filetypes_denylist = { "NvimTree", "oil", "spectre_panel", "trouble" },
        delay = 100,
        large_file_cutoff = 5000,
      })
    end,
  },
  {
    "levouh/tint.nvim",
    enabled = false,
    config = require("config.plugins.tint").setup,
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
  ---actually helpful.
  {
    "olrtg/nvim-emmet",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "v" }, "<C-y>", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = require("config.plugins.neoscroll").setup,
  },
  {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    opts = {},
  },
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
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { "junegunn/fzf", "nvim-treesitter/nvim-treesitter" },
    ft = "qf",
    opts = {},
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
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
  {
    "ggandor/leap.nvim",
    enabled = true,
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
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
    cmd = { "Gdiffsplit", "Git", "Gvdiffsplit" },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
    config = require("config.plugins.neogit").setup,
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
    cmd = "Oil",
    keys = { { "<leader><space>", "<CMD>Oil<CR>" } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.oil").setup,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      outline_window = {
        width = 40,
        relative_width = false,
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    keys = {
      { "<C-s>", "<cmd>Spectre<cr>", desc = "Search" },
    },
    config = require("config.plugins.spectre").setup,
  },
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
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    opts = {
      remove_template_string = true,
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "ToggleTrouble", "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.trouble").setup,
  },
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
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.bufferline").setup,
  },
  {
    "zenbones-theme/zenbones.nvim",
    enabled = false,
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    config = function()
      vim.cmd("colorscheme zenburned")
    end,
  },
  {
    "catppuccin/nvim",
    enabled = true,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = require("config.plugins.catppuccin").setup,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      -- Snippet Engine
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      -- LSP completion
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- LSP kind
      -- "onsails/lspkind.nvim",
    },
    config = require("config.plugins.cmp").setup,
  },
  {
    "mfussenegger/nvim-lint",
    cmd = { "Lint", "LintWithBiome", "LintWithEslint" },
    config = require("config.plugins.lint").setup,
  },
  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
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
    config = require("config.plugins.grug-far").setup,
  },
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("notify").setup({
            render = "wrapped-compact",
            stages = "static",
            timeout = 1500,
            top_down = false,
          })
        end,
      },
    },
    config = require("config.plugins.noice").setup,
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.nvim-tree").setup,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      session_lens = {
        load_on_setup = false,
      },
    },
  },
  {
    "folke/persistence.nvim",
    enabled = false,
    lazy = false,
    config = require("config.plugins.persistence").setup,
  },
  {
    "dstein64/nvim-scrollview",
    enabled = false,
    event = "VeryLazy",
    config = require("config.plugins.scrollview").setup,
  },
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      -- resize
      {
        "<S-Down>",
        function()
          require("smart-splits").resize_down()
        end,
      },
      {
        "<S-Left>",
        function()
          require("smart-splits").resize_left()
        end,
      },
      {
        "<S-Right>",
        function()
          require("smart-splits").resize_right()
        end,
      },
      {
        "<S-Up>",
        function()
          require("smart-splits").resize_up()
        end,
      },
      -- moving
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
      },
      -- swapping
      {
        "<leader><leader>h",
        function()
          require("smart-splits").swap_buf_left()
        end,
      },
      {
        "<leader><leader>j",
        function()
          require("smart-splits").swap_buf_down()
        end,
      },
      {
        "<leader><leader>k",
        function()
          require("smart-splits").swap_buf_up()
        end,
      },
      {
        "<leader><leader>l",
        function()
          require("smart-splits").swap_buf_right()
        end,
      },
    },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = { "<leader>a", "<leader>c", "<leader>e", "<leader>f", "<leader>l" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = require("config.plugins.telescope").setup,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoLocList" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("config.plugins.todos").setup,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = require("config.plugins.treesitter").setup,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>tj", mode = "n", ":TSJJoin<CR>", silent = true },
      { "<leader>tm", mode = "n", ":TSJToggle<CR>", silent = true },
      { "<leader>ts", mode = "n", ":TSJSplit<CR>", silent = true },
    },
    opts = {},
  },
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          require("statuscol").setup({
            relculright = true,
            ft_ignore = { "NvimTree", "Outline" },
            segments = {
              -- number column
              { text = { "  ", require("statuscol.builtin").lnumfunc }, click = "v:lua.ScLa" },
              -- fold column
              { text = { " ", require("statuscol.builtin").foldfunc, " " }, click = "v:lua.ScFa" },
            },
          })
        end,
      },
    },
    config = require("config.plugins.ufo").setup,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = { "NoNeckPain", "NoNeckPainWidthDown", "NoNeckPainWidthUp" },
    keys = {
      {
        "<leader>z",
        function()
          vim.cmd("NoNeckPain")
        end,
        mode = "n",
      },
    },
    version = "*",
    config = require("config.plugins.no-neck-pain").setup,
  },
  { "Bilal2453/luvit-meta", lazy = true },
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
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
    config = require("config.plugins.lsp").setup,
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = "VeryLazy",
    cmd = { "Format" },
    keys = {
      {
        "<leader>m",
        function()
          vim.cmd("Format")
        end,
        mode = "n",
      },
    },
    config = require("config.plugins.conform").setup,
  },
}, {
  change_detection = {
    enabled = false,
    notify = true,
  },
  concurrency = 6,
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    backdrop = 100,
    border = "single", -- "rounded", "single"
  },
})
