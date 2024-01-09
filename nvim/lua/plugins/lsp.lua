return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      -- Snippet Engine
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- LSP completion
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- LSP kind
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local kind_icons = {
        Class = "󰠱",
        Color = "󰏘",
        Constant = "󰏿",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "󰇽",
        File = "󰈙",
        Folder = "󰉋",
        Function = "󰊕",
        Interface = "",
        Keyword = "󰌋",
        Method = "󰆧",
        Module = "",
        Operator = "󰆕",
        Property = "󰜢",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "󰅲",
        Unit = "",
        Value = "󰎠",
        Variable = "󰂡",
      }

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
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          format = function(entry, vim_item)
            local lspkind_ok, lspkind = pcall(require, "lspkind")
            if not lspkind_ok then
              -- From kind_icons array
              vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
              -- Source
              vim_item.menu = ({
                buffer = "[Buffer]",
                luasnip = "[LuaSnip]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
              })[entry.source.name]
              return vim_item
            else
              -- From lspkind
              return lspkind.cmp_format()(entry, vim_item)
            end
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        {
          workspace = {
            -- PERF: didChangeWatchedFiles is too slow.
            -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
            didChangeWatchedFiles = { dynamicRegistration = false },
          },
        }
      )

      require("mason").setup()

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "angularls",
          "cssls",
          "cssmodules_ls",
          "dockerls",
          "eslint",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "prismals",
          "pyright",
          "tailwindcss",
          "tsserver",
          "yamlls",
        },
      })

      require("mason-lspconfig").setup_handlers({
        -- server defaults
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- server overrides
        ["jsonls"] = function()
          -- NOTE: to add new schemas, find url here https://www.schemastore.org/json/
          require("lspconfig").jsonls.setup({
            capabilities = capabilities,
            settings = {
              json = {
                schemas = {
                  { fileMatch = { "jsconfig.json" }, url = "https://json.schemastore.org/jsconfig" },
                  { fileMatch = { "tsconfig.json" }, url = "https://json.schemastore.org/tsconfig" },
                  { fileMatch = { "turbo.json" }, url = "https://turbo.build/schema.json" },
                  { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package" },
                  {
                    fileMatch = { ".prettierrc.json", ".prettierrc" },
                    url = "https://json.schemastore.org/prettierrc.json",
                  },
                  { fileMatch = { ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
                },
              },
            },
          })
        end,
        ["gopls"] = function()
          require("lspconfig").gopls.setup({
            capabilities = capabilities,
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = require("lspconfig.util").root_pattern("go.mod", "go.work", ".git"),
            settings = {
              gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                  unusedparams = true,
                },
              },
            },
          })
        end,
        ["lua_ls"] = function()
          require("neodev").setup({})
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = { Lua = { workspace = { checkThirdParty = false } } },
          })
        end,
        ["tailwindcss"] = function()
          require("lspconfig").tailwindcss.setup({
            capabilities = capabilities,
            settings = {
              tailwindCSS = {
                classAttributes = {
                  "class",
                  "className",
                },
              },
            },
          })
        end,
        ["tsserver"] = function()
          require("lspconfig").tsserver.setup({
            capabilities = capabilities,
            root_dir = require("lspconfig.util").root_pattern(".git"),
          })
        end,
        ["yamlls"] = function()
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
          })
        end,
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
