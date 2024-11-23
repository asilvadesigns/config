require("lazy").setup({
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
  { lazy = true, "nvim-lua/plenary.nvim" },
  { lazy = true, "nvim-tree/nvim-web-devicons" },
  --
  -- emmet
  {
    "olrtg/nvim-emmet",
    ft = { "html", "templ", "typescriptreact", "javascriptreact" },
    config = function()
      vim.keymap.set({ "v" }, "<C-y>", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },
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
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
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
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      ---@usage 'background'|'foreground'|'virtual'
      -- render = "virtual",
      -- virtual_symbol = '■',
      -- virtual_symbol = '⬤',
    },
  },
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
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
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
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    version = "*",
    opts = {
      delay = 25,
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "ToggleTrouble", "Trouble" },
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
    enabled = true,
    version = "*",
    config = require("config.plugins.bufferline").setup,
  },
  --
  -- colorscheme
  -- {
  --   dir = "~/.config/nvim/colors",
  --   name = "minimal",
  --   lazy = false,
  --   enabled = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("minimal")
  --   end,
  -- },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd("set background=dark")
      vim.cmd.colorscheme("nord")
    end,
  },
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd("set background=light")
      vim.cmd.colorscheme("onenord")
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    -- dependencies = "rktjmp/lush.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      -- vim.g.zenbones_darken_comments = 45
      vim.cmd("set background=light") ---or light if you want light mode
      vim.g.zenbones_compat = 1
      vim.cmd.colorscheme("zenbones")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd("set background=dark ") ---or light if you want light mode
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.o.background = "light"
      vim.g.gruvbox_material_background = "soft"
      -- vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_foreground = "mix"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "catppuccin/nvim",
    enabled = true,
    lazy = false,
    -- event = "VeryLazy",
    name = "catppuccin",
    -- priority = 1000,
    config = require("config.plugins.catppuccin").setup,
  },
  --
  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "VeryLazy",
    config = require("config.plugins.cmp").setup,
  },
  --
  -- search
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
  --
  -- interface
  { lazy = true, "MunifTanjim/nui.nvim" },
  {
    lazy = true,
    "rcarriga/nvim-notify",
    opts = {
      render = "wrapped-compact",
      stages = "static",
      timeout = 1500,
      top_down = false,
    },
  },
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    config = require("config.plugins.noice").setup,
  },
  --
  -- file tree
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
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = { { "<leader><space>", "<CMD>Oil<CR>" } },
    config = require("config.plugins.oil").setup,
  },
  --
  -- session
  {
    "rmagatti/auto-session",
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
  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "CursorMoved",
    enabled = false,
    config = function()
      require("mini.indentscope").setup({
        -- Draw options
        draw = {
          -- Delay (in ms) between event and start of drawing scope indicator
          delay = 48,

          -- Animation rule for scope's first drawing. A function which, given
          -- next and total step numbers, returns wait time (in ms). See
          -- |MiniIndentscope.gen_animation| for builtin options. To disable
          -- animation, use `require('mini.indentscope').gen_animation.none()`.
          animation = require("mini.indentscope").gen_animation.none(),

          -- Symbol priority. Increase to display on top of more symbols.
          priority = 2,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Textobjects
          object_scope = "",
          object_scope_with_border = "",
          -- Motions (jump to respective border line; if not present - body line)
          goto_top = "",
          goto_bottom = "",
        },

        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller indent to
          -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
          border = "both",

          -- Whether to use cursor column when computing reference indent.
          -- Useful to see incremental scopes with horizontal cursor movements.
          indent_at_cursor = true,

          -- Whether to first check input line to be a border of adjacent scope.
          -- Use it if you want to place cursor on function header to get scope of
          -- its body.
          try_as_border = false,
        },

        -- Which character to use for drawing scope indicator
        symbol = "│",
      })

      vim.cmd("hi! link MiniIndentscopeSymbol Comment")
    end,
  },
  --
  -- scrolling
  {
    "karb94/neoscroll.nvim",
    enabled = false,
    event = "VeryLazy",
    config = require("config.plugins.neoscroll").setup,
  },
  {
    "dstein64/nvim-scrollview",
    enabled = false,
    event = "VeryLazy",
    config = require("config.plugins.scrollview").setup,
  },
  --
  -- splits
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
  -- telescope
  -- { lazy = true, "nvim-telescope/telescope-ui-select.nvim" },
  -- { lazy = true, "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    enabled = true,
    cmd = { "Telescope" },
    keys = { "<leader>a", "<leader>c", "<leader>e", "<leader>f", "<leader>l" },
    config = require("config.plugins.telescope").setup,
  },
  -- fzf lua
  {
    "ibhagwan/fzf-lua",
    enabled = false,
    event = "VeryLazy",
    keys = {
      {
        "<leader>a",
        function()
          require("fzf-lua").commands()
        end,
      },
      {
        "<leader>c",
        function()
          require("fzf-lua").fzf_exec({ "line1", "line2" }, {
            actions = {
              ["enter"] = function(selected)
                vim.print("selected..." .. vim.inspect(selected))
              end,
            },
          })
        end,
      },
      {
        "<leader>b",
        function()
          require("fzf-lua").builtin()
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
  --
  -- commenting
  { lazy = true, "JoosepAlviste/nvim-ts-context-commentstring" },
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
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoLocList" },
    config = require("config.plugins.todos").setup,
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    -- event = {
    build = ":TSUpdate",
    -- NOTE: I saw this somewhere but I don't know if it actually helps
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
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
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>tj", mode = "n", ":TSJJoin<CR>", silent = true },
      { "<leader>tm", mode = "n", ":TSJToggle<CR>", silent = true },
      { "<leader>ts", mode = "n", ":TSJSplit<CR>", silent = true },
    },
    opts = {},
  },
  -- folding
  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    -- event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        opts = function()
          local builtin = require("statuscol.builtin")

          return {
            relculright = true,
            ft_ignore = { "NvimTree" },
            segments = {
              { text = { "  ", builtin.lnumfunc }, click = "v:lua.ScLa" },
              { text = { " ", builtin.foldfunc }, click = "v:lua.ScFa" },
            },
          }
        end,
      },
    },
    config = require("config.plugins.ufo").setup,
  },
  --
  -- language server
  { lazy = true, "Bilal2453/luvit-meta" },
  { lazy = true, "hrsh7th/cmp-nvim-lsp" },
  { lazy = true, "williamboman/mason-lspconfig.nvim" },
  { lazy = true, "williamboman/mason.nvim" },
  {
    "folke/lazydev.nvim",
    event = "VeryLazy",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = require("config.plugins.lsp").setup,
  },
  --
  -- linting
  {
    "mfussenegger/nvim-lint",
    cmd = { "Lint", "LintWithBiome", "LintWithEslint" },
    config = require("config.plugins.lint").setup,
  },
  --
  -- formatting
  {
    "stevearc/conform.nvim",
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
  --
  -- zen mode
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
}, {
  change_detection = {
    enabled = false,
    notify = true,
  },
  concurrency = 6,
  defaults = {
    lazy = true,
  },
  dev = {
    path = "~/.config/nvim/plugins/",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
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
    border = "rounded", -- "rounded", "single"
  },
})
