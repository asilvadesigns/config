return {
  {
    "utilyre/barbecue.nvim",
    enabled = true,
    name = "barbecue",
    version = "*",
    lazy = false,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  -- {
  --   "SmiteshP/nvim-navic",
  --   config = function()
  --     require("nvim-navic").setup({
  --       lsp = {
  --         auto_attach = true,
  --       },
  --     })
  --   end,
  -- },
  {
    "Bekaboo/dropbar.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require("dropbar").setup({
        icons = {
          enable = true,
          kinds = {
            use_devicons = true,
            symbols = {
              Array = "󰅪 ",
              Boolean = " ",
              BreakStatement = "󰙧 ",
              Call = "󰃷 ",
              CaseStatement = "󱃙 ",
              Class = " ",
              Color = "󰏘 ",
              Constant = "󰏿 ",
              Constructor = " ",
              ContinueStatement = "→ ",
              Copilot = " ",
              Declaration = "󰙠 ",
              Delete = "󰩺 ",
              DoStatement = "󰑖 ",
              Enum = " ",
              EnumMember = " ",
              Event = " ",
              Field = " ",
              File = "󰈔 ",
              -- Folder = "󰉋 ",
              Folder = "",
              ForStatement = "󰑖 ",
              Function = "󰊕 ",
              H1Marker = "󰉫 ", -- Used by markdown treesitter parser
              H2Marker = "󰉬 ",
              H3Marker = "󰉭 ",
              H4Marker = "󰉮 ",
              H5Marker = "󰉯 ",
              H6Marker = "󰉰 ",
              Identifier = "󰀫 ",
              IfStatement = "󰇉 ",
              Interface = " ",
              Keyword = "󰌋 ",
              List = "󰅪 ",
              Log = "󰦪 ",
              Lsp = " ",
              Macro = "󰁌 ",
              MarkdownH1 = "󰉫 ", -- Used by builtin markdown source
              MarkdownH2 = "󰉬 ",
              MarkdownH3 = "󰉭 ",
              MarkdownH4 = "󰉮 ",
              MarkdownH5 = "󰉯 ",
              MarkdownH6 = "󰉰 ",
              Method = "󰆧 ",
              Module = "󰏗 ",
              Namespace = "󰅩 ",
              Null = "󰢤 ",
              Number = "󰎠 ",
              Object = "󰅩 ",
              Operator = "󰆕 ",
              Package = "󰆦 ",
              Pair = "󰅪 ",
              Property = " ",
              Reference = "󰦾 ",
              Regex = " ",
              Repeat = "󰑖 ",
              Scope = "󰅩 ",
              Snippet = "󰩫 ",
              Specifier = "󰦪 ",
              Statement = "󰅩 ",
              String = "󰉾 ",
              Struct = " ",
              SwitchStatement = "󰺟 ",
              Terminal = " ",
              Text = " ",
              Type = " ",
              TypeParameter = "󰆩 ",
              Unit = " ",
              Value = "󰎠 ",
              Variable = "󰀫 ",
              WhileStatement = "󰑖 ",
            },
          },
        },
      })

      vim.keymap.set("n", "<leader><space>", function()
        require("dropbar.api").pick()
      end, {})
    end,
  },
}
