vim.cmd("hi! link LazyNormal Normal")

local get_diagnostics = function(props)
  local d_label = {}
  local d_count = vim.diagnostic.count(props.buf)
  local square = vim.fn.nr2char(0x25aa)

  if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.ERROR], group = "DiagnosticSignError" })
  end
  if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.HINT], group = "DiagnosticSignHint" })
  end
  if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.INFO], group = "DiagnosticSignInfo" })
  end
  if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.WARN], group = "DiagnosticSignWarn" })
  end

  return { d_label }
end

require("lazy").setup({
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      clear_empty_lines = false,
      keys = "<Esc>",
      mapping = { "kj" },
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
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      { "S", false, mode = { "v" } },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
    config = require("config.plugins.flash").setup,
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
    keys = { { "<leader>x", "<CMD>Oil<CR>" } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.oil").setup,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
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
      { "<c-s>", "<cmd>Spectre<cr>", desc = "Search" },
      {
        "<c-f>",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Search current file",
      },
    },
    opts = {},
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
    keys = {
      { "<C-N>", mode = "n" },
      { "<C-N>", mode = "x" },
    },
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
    "RRethy/vim-illuminate",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        filetypes_denylist = { "NvimTree", "oil", "spectre_panel", "trouble" },
        delay = 100,
        large_file_cutoff = 5000, -- disable at 5k lines.
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "TabNew",
    dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.bufferline").setup,
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
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet Engine
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- LSP completion
      "David-Kunz/cmp-npm",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- LSP kind
      "onsails/lspkind.nvim",
    },
    config = require("config.plugins.cmp").setup,
  },
  {
    "ThePrimeagen/harpoon",
    enabled = false,
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = require("config.plugins.harpoon").setup,
  },
  {
    "mfussenegger/nvim-lint",
    cmd = { "Lint", "LintWithBiome", "LintWithEslint" },
    config = require("config.plugins.lint").setup,
  },
  {
    "MagicDuck/grug-far.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("grug-far").setup()
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
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
          -- local api = require("nvim-tree.api")
          --
          -- if api.tree.is_visible() then
          --   api.tree.close()
          -- else
          --   api.tree.toggle()
          --   -- api.tree.toggle({ current_window = true })
          -- end
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("config.plugins.nvim-tree").setup,
  },
  {
    "folke/persistence.nvim",
    lazy = false,
    cmd = { "LoadSession", "SaveSession" },
    config = require("config.plugins.persistence").setup,
  },
  {
    "dstein64/nvim-scrollview",
    enabled = true,
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
    event = "VeryLazy",
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
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          require("statuscol").setup({
            relculright = true,
            segments = {
              -- { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { "  ", require("statuscol.builtin").lnumfunc, " " }, click = "v:lua.ScLa" },
              { text = { require("statuscol.builtin").foldfunc, " " }, click = "v:lua.ScFa" },
            },
          })
        end,
      },
    },
    config = require("config.plugins.ufo").setup,
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    config = require("config.plugins.zen-mode").setup,
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
    opts = { width = 120 },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        {
          path = "luvit-meta/library",
          words = { "vim%.uv" },
        },
      },
    },
  },
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { default = true, group = "Normal" },
            InclineNormalNC = { default = true, group = "Normal" },
          },
        },
        render = function(props)
          local diagnostics = get_diagnostics(props)
          local filename = { vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t"), group ="Comment" }

          return { filename, diagnostics }
        end,
      })

      vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
        group = vim.api.nvim_create_augroup("render_incline", { clear = true }),
        callback = function()
          require("incline").refresh()
        end,
      })
    end,
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
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = false },
      })
    end,
  },
}, {
  change_detection = {
    enabled = false,
    notify = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
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
    border = "rounded",
  },
})
