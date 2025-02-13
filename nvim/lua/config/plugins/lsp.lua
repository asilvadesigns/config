local M = {}

M.setup = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = false,
    },
  }

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local servers = {
    "angularls",
    "astro",
    "clangd",
    "cssls",
    "dockerls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "prismals",
    -- "pyright",
    "sqlls",
    "tailwindcss",
    "taplo",
    -- "templ",
    "ts_ls",
    -- "volar",
    "yamlls",
  }

  local formatters = {
    "htmlbeautifier",
    "prettier",
    "sql-formatter",
    "stylua",
  }

  require("mason").setup({
    ui = { border = "rounded" },
  })

  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = servers,
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,
    ["cssls"] = function()
      require("lspconfig").cssls.setup({
        capabilities = capabilities,
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
      -- NOTE: new schemas see here https://www.schemastore.org/json/
      require("lspconfig").jsonls.setup({
        capabilities = capabilities,
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

      vim.keymap.set("n", "g.", vim.lsp.buf.code_action, opts)

      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, opts)

      vim.keymap.set("n", "gd", function()
        Snacks.picker.lsp_definitions()
      end, opts)

      vim.keymap.set("n", "gi", function()
        Snacks.picker.lsp_implementations()
      end, opts)

      vim.keymap.set("n", "gr", function()
        Snacks.picker.lsp_references()
      end, opts)
    end,
  })

  local start_lsp = vim.schedule_wrap(function()
    --- NOTE: https://github.com/wookayin/dotfiles/blob/f2c7b0944135f33db83b218afa2da89fb4b3ef1c/nvim/lua/config/lsp.lua#L318
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local valid = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
      if valid and vim.bo[bufnr].buftype == "" then
        local augroup_lspconfig = vim.api.nvim_create_augroup("lspconfig", { clear = false })
        vim.api.nvim_exec_autocmds("FileType", { group = augroup_lspconfig, buffer = bufnr })
      end
    end
  end)

  vim.defer_fn(function()
    start_lsp()
  end, 100)
end

return M
