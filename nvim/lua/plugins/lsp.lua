return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = "VeryLazy" ,
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

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr
      vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
      vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
      vim.keymap.set("n", "gl", function()
        require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
      end, opts)
      vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
    end

    -- NOTE: some of these are listed below but... getting there.
    local ensure_installed = {
      "angularls",
      "cssls",
      "cssmodules_ls",
      "dockerls",
      "emmet_language_server",
      "eslint",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "prismals",
      "pyright",
      "sqlls",
      "stylelua",
      "stylua",
      "tailwindcss",
      "taplo",
      "templ",
      "tsserver",
      "yamlls",
    }

    require("mason").setup({})

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
    end, {})

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed,
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
                {
                  fileMatch = { "sqlc.json" },
                  url = { "https://json.schemastore.org/sqlc-2.0.json" },
                },
                {
                  fileMatch = { "jsconfig.json" },
                  url = "https://json.schemastore.org/jsconfig",
                },
                {
                  fileMatch = { "tsconfig.json" },
                  url = "https://json.schemastore.org/tsconfig",
                },
                {
                  fileMatch = { "turbo.json" },
                  url = "https://turbo.build/schema.json",
                },
                {
                  fileMatch = { "package.json" },
                  url = "https://json.schemastore.org/package",
                },
                {
                  fileMatch = { ".prettierrc.json", ".prettierrc" },
                  url = "https://json.schemastore.org/prettierrc.json",
                },
                {
                  fileMatch = { ".eslintrc.json" },
                  url = "https://json.schemastore.org/eslintrc.json",
                },
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
      ["emmet_language_server"] = function()
        require("lspconfig").emmet_language_server.setup({
          capabilities = capabilities,
          filetypes = { "html", "templ" },
          on_attach = on_attach,
        })
      end,
      ["html"] = function()
        require("lspconfig").html.setup({
          capabilities = capabilities,
          filetypes = { "html", "templ" },
          on_attach = on_attach,
        })
      end,
      ["htmx"] = function()
        require("lspconfig").htmx.setup({
          capabilities = capabilities,
          filetypes = { "html", "templ" },
          on_attach = on_attach,
          root_dir = require("lspconfig.util").root_pattern("go.mod", "go.work", ".git"),
          single_file_support = true,
        })
      end,
      ["lua_ls"] = function()
        require("neodev").setup()
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
          filetypes = {
            "astro",
            "html",
            "javascript",
            "react",
            "templ",
            "typescript",
            "typescriptreact",
          },
          init_options = { userLanguages = { templ = "html" } },
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
      -- ["sqlls"] = function ()
      --   require("lspconfig").sqlls.setup({
      --     capabilities = capabilities,
      --     on_attach = on_attach,
      --     root_dir = require("lspconfig.util").root_pattern(".git"),
      --   })
      -- end,
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

    vim.api.nvim_create_user_command("GetActiveLSPs", function()
      local clients = vim.lsp.get_active_clients()
      local clients_list = {}
      for _, client in pairs(clients) do
        table.insert(clients_list, client.name)
      end

      print("active lsps")
      print(vim.inspect(clients_list))
    end, {})

    ---https://github.com/wookayin/dotfiles/blob/f2c7b0944135f33db83b218afa2da89fb4b3ef1c/nvim/lua/config/lsp.lua#L318
    local attach_lsp_to_existing_buffers = vim.schedule_wrap(function()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local valid = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buflisted")
        if valid and vim.bo[bufnr].buftype == "" then
          local augroup_lspconfig = vim.api.nvim_create_augroup("lspconfig", { clear = false })
          vim.api.nvim_exec_autocmds("FileType", { group = augroup_lspconfig, buffer = bufnr })
        end
      end
    end)

    attach_lsp_to_existing_buffers()
  end,
}
