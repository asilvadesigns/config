local M = {}

M.setup = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- local capabilities = vim.tbl_deep_extend(
  --   "force",
  --   vim.lsp.protocol.make_client_capabilities(),
  --   require("cmp_nvim_lsp").default_capabilities()
  -- )

  -- NOTE: using blink
  -- local capabilities = require("blink.cmp").get_lsp_capabilities()
  -- capabilities["workspace"] = {
  --   didChangeWatchedFiles = { dynamicRegistration = false },
  -- }
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local servers = {
    "angularls",
    "astro",
    "clangd",
    "cssls",
    -- "cssmodules_ls",
    "dockerls",
    -- "emmet_language_server",
    "eslint", -- TODO: should probably add the root util...
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
    "ts_ls",
    "volar",
    "yamlls",
  }

  local formatters = {
    "htmlbeautifier",
    "prettier",
    "sql-formatter",
    "stylua",
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- local navic = require("nvim-navic")

  require("mason").setup({
    ui = { border = "rounded" },
  })

  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = servers,
  })

  vim.cmd("hi! link MasonNormal Normal")

  local on_attach = function(client, bufnr)
    -- if client.server_capabilities.documentSymbolProvider then
    --   navic.attach(client, bufnr)
    -- end
  end

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
        on_attach = on_attach,
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
    ["ts_ls"] = function()
      local volar_path = require("mason-registry").get_package("vue-language-server"):get_install_path()
      local home_path = vim.fn.expand("~")

      require("lspconfig").ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "non-relative",
          },
          plugins = {
            {
              name = "ts-lit-plugin",
              location = home_path
                .. "/Library/Application Support/fnm/node-versions/v22.11.0/installation/lib/node_modules/ts-lit-plugin/",
            },
            {
              name = "@vue/typescript-plugin",
              location = volar_path .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
              languages = { "vue" },
            },
          },
        },
      })
    end,
    ["volar"] = function()
      local ts_path = require("mason-registry").get_package("typescript-language-server"):get_install_path()

      require("lspconfig").volar.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          vue = {
            hybridMode = false,
          },
          typescript = {
            tsdk = ts_path .. "/node_modules/typescript/lib",
          },
        },
      })
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local opts = { silent = true, buffer = ev.buf }

      vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      -- telescope
      -- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
      -- vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
      -- vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
      -- vim.keymap.set("n", "gl", function()
      --   require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
      -- end, opts)

      -- fzflua
      vim.keymap.set("n", "gd", function()
        require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
      end, opts)
      vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations, opts)
      vim.keymap.set("n", "gr", require("fzf-lua").lsp_references, opts)
      vim.keymap.set("n", "gl", function()
        require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
      end, opts)
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

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(servers, " "))
    local registry = require("mason-registry")

    for _, pkg_name in ipairs(formatters) do
      local ok, pkg = pcall(registry.get_package, pkg_name)
      if ok then
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end
  end, {})

  --- https://github.com/wookayin/dotfiles/blob/f2c7b0944135f33db83b218afa2da89fb4b3ef1c/nvim/lua/config/lsp.lua#L318
  local attach_lsp_to_existing_buffers = vim.schedule_wrap(function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local valid = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
      if valid and vim.bo[bufnr].buftype == "" then
        local augroup_lspconfig = vim.api.nvim_create_augroup("lspconfig", { clear = false })
        vim.api.nvim_exec_autocmds("FileType", { group = augroup_lspconfig, buffer = bufnr })
      end
    end
  end)

  vim.defer_fn(function()
    attach_lsp_to_existing_buffers()
  end, 400)
end

return M
