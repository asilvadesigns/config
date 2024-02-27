return {
  {
    enabled = false,
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "nvim-telescope/telescope.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local telescope = require("telescope.builtin")

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

      local opts = { noremap = true, silent = true }
      local on_attach = function(client, bufnr)
        opts.buffer = bufnr
        vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
        vim.keymap.set("n", "gr", telescope.lsp_references, opts)
      end

      -- NOTE: some of these are listed below but... getting there.
      local ensure_installed = {
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
        "stylelua",
        "stylua",
        "tailwindcss",
        "tsserver",
        "yamlls",
      }

      require("mason").setup({})

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
      end, {})

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
            on_attach = on_attach,
          })
        end,

        -- server overrides
        ["jsonls"] = function()
          -- NOTE: to add new schemas, find url here https://www.schemastore.org/json/
          require("lspconfig").jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern("go.mod", "go.work", ".git"),
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                completeUnimported = true,
                usePlaceholders = true,
              },
            },
          })
        end,
        ["lua_ls"] = function()
          require("neodev").setup({})
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          })
        end,
        ["tailwindcss"] = function()
          require("lspconfig").tailwindcss.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.ts",
              "tailwind.config.cjs"
            ),
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
            on_attach = on_attach,
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
            on_attach = on_attach,
          })
        end,
      })

      -- TODO: make
      vim.api.nvim_create_user_command("GetActiveLSPs", function()
        local clients = vim.lsp.get_active_clients()
        local clients_list = {}
        for _, client in pairs(clients) do
          table.insert(clients_list, client.name)
        end

        print("active lsps")
        print(vim.inspect(clients_list))
      end, {})
    end,
  },
}
