local M = {}

M.setup = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
  capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local opts = { noremap = true, silent = true }

  local on_attach = function(_, bufnr)
    opts.buffer = bufnr
    vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
    vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
    vim.keymap.set("n", "gl", function()
      require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
    end, opts)
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
  end

  local servers = {
    "angularls",
    "astro",
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
    "tailwindcss",
    "taplo",
    "templ",
    "tsserver",
    "yamlls",
  }

  local formatters = {
    "htmlbeautifier",
    "sql-formatter",
    "stylua",
  }

  require("mason").setup({
    ui = { border = "single" }, -- "rounded"
  })

  vim.cmd("hi! link MasonNormal Normal")

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(servers, " "))
    local registry = require("mason-registry")

    ---@see https://github.com/williamboman/mason-lspconfig.nvim/issues/113#issuecomment-1471346816
    for _, pkg_name in ipairs(formatters) do
      local ok, pkg = pcall(registry.get_package, pkg_name)
      if ok then
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end
  end, {})

  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = servers,
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,

    ["cssls"] = function()
      require("lspconfig").cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          css = {
            lint = {
              -- fixes unknown @tailwind rule for css files
              unknownAtRules = "ignore",
            },
          },
          scss = {
            lint = {
              -- fixes unknown @tailwind rule for sass files
              unknownAtRules = "ignore",
            },
          },
        },
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
        filetypes = { "astro", "html", "templ" },
        on_attach = on_attach,
      })
    end,
    ["html"] = function()
      require("lspconfig").html.setup({
        capabilities = capabilities,
        filetypes = { "astro", "html", "templ" },
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
      -- require("neodev").setup()
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
          "css",
          "html",
          "javascript",
          "react",
          "scss",
          "templ",
          "typescript",
          "typescriptreact",
        },
        init_options = { userLanguages = { templ = "html" } },
        on_attach = on_attach,
        -- root_dir = require("lspconfig.util").root_pattern(
        --   "tailwind.config.js",
        --   "tailwind.config.ts",
        --   "tailwind.config.cjs"
        -- ),
        settings = {
          tailwindCSS = {
            classAttributes = {
              "class",
              "className",
              "x-transition:enter",
              "x-transition:enter-start",
              "x-transition:enter-end",
              "x-transition:leave",
              "x-transition:leave-start",
              "x-transition:leave-end",
            },
            includeLanguages = {
              templ = "html",
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
    ["templ"] = function()
      require("lspconfig").templ.setup({
        capabilities = capabilities,
        on_attach = on_attach,
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

  vim.api.nvim_create_user_command("GetActiveLSPs", function()
    local clients = vim.lsp.get_clients()
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
      local valid = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
      if valid and vim.bo[bufnr].buftype == "" then
        local augroup_lspconfig = vim.api.nvim_create_augroup("lspconfig", { clear = false })
        vim.api.nvim_exec_autocmds("FileType", { group = augroup_lspconfig, buffer = bufnr })
      end
    end
  end)

  attach_lsp_to_existing_buffers()
end

return M
