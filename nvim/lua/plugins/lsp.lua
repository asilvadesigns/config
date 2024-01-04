return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      require("neodev").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      require("mason").setup()

      require("mason-lspconfig").setup({
        capabilities = capabilities,
        automatic_installation = true,
      })

      -- Angular
      require("lspconfig").angularls.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- CSS
      require("lspconfig").cssls.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- CSS Modules
      require("lspconfig").cssmodules_ls.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- Eslint
      require("lspconfig").eslint.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- Go
      require("lspconfig").gopls.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- Lua
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        settings = { Lua = { workspace = { checkThirdParty = false } } },
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- Tailwind
      require("lspconfig").tailwindcss.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- TypeScript
      require("lspconfig").tsserver.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      -- Yaml
      require("lspconfig").yamlls.setup({
        capabilities = vim.tbl_extend("force", capabilities, {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        }),
        filetypes = { "yaml", "yaml.docker-compose", "yml" },
        -- settings = {
        --   yaml = {
        --     schemaStore = {
        --       enable = true,
        --       url = "https://www.schemastore.org/api/json/catalog.json",
        --     }
        --   }
        -- },
        root_dir = require("lspconfig.util").root_pattern(".git"),
      })

      local telescope = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", telescope.lsp_definitions, {})
      vim.keymap.set("n", "gr", telescope.lsp_references, {})
    end,
  },
}
