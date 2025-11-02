local M = {}

M.setup = function()
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  --
  -- capabilities = {
  --   textDocument = {
  --     definition = {
  --       dynamicRegistration = false,
  --     },
  --     foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true,
  --     },
  --   },
  --   workspace = {
  --     didChangeWatchedFiles = {
  --       dynamicRegistration = false,
  --     },
  --   },
  -- }

  -- local servers = {
  --   "angularls",
  --   "astro",
  --   "clangd",
  --   "cssls",
  --   "dockerls",
  --   "eslint",
  --   "gopls",
  --   "html",
  --   "jsonls",
  --   "lua_ls",
  --   "prismals",
  --   "tailwindcss",
  --   "taplo",
  --   "templ",
  --   "vtsls",
  --   "yamlls",
  -- }
  --
  -- local formatters = {
  --   "htmlbeautifier",
  --   "prettier",
  --   "sql-formatter",
  --   "stylua",
  -- }

  require("mason").setup({
    ui = {
      border = "rounded",
      backdrop = 100,
    },
  })

  --- C/C++
  vim.lsp.config("clangd", {})
  vim.lsp.enable("clangd")

  --- CSS
  vim.lsp.config("cssls", {
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
  vim.lsp.enable("cssls")

  --- HTML
  local htmldefaults = require("lspconfig.configs.html").default_config
  vim.lsp.config("html", {
    filetypes = vim.list_extend({ "templ" }, htmldefaults.filetypes),
  })
  vim.lsp.enable("html")

  --- JSON
  vim.lsp.config("jsonls", {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
  vim.lsp.enable("jsonls")

  --- GLSL
  vim.lsp.config("glsl_analyzer", {})
  vim.lsp.enable("glsl_analyzer")

  --- GO
  vim.lsp.config("gopls", {
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
  vim.lsp.enable("gopls")

  --- LUA
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })
  vim.lsp.enable("lua_ls")

  --- TAILWIND
  local tailwind_defaults = require("lspconfig.configs.tailwindcss").default_config
  vim.lsp.config("tailwindcss", {
    filetypes = vim.list_extend({ "go" }, tailwind_defaults.filetypes),
    setttings = {
      tailwindCSS = {
        includeLanguages = {
          templ = "html",
        },
        experimental = {
          classRegex = {
            'Class\\("([^"]*)"\\)',
            'activeClass\\("([^"]*)"\\)',
          },
        },
      },
    },
  })
  vim.lsp.enable("tailwindcss")

  --- TYPESCRIPT
  vim.lsp.config("vtsls", {
    settings = {
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
      },
      typescript = {
        suggest = {
          autoImports = true,
        },
      },
    },
  })
  vim.lsp.enable("vtsls")

  --- YAML
  vim.lsp.config("yamlls", {})
  vim.lsp.enable("yamlls")

  --- POSTGRES
  vim.lsp.config("postgres_lsp", {
    cmd = { "postgrestools", "lsp-proxy", "--config-path", vim.fn.getcwd() .. "/postgrestools.jsonc" },
    filetypes = { "sql", "postgres" },
    root_dir = require("lspconfig").util.root_pattern("postgrestools.jsonc"),
  })
  vim.lsp.enable("postgres_lsp")

  --- SWIFT
  vim.lsp.config("sourcekit", {
    filetypes = { "swift" },
  })
  vim.lsp.enable("sourcekit")

  --- ZIG
  vim.lsp.config("zig", {})
  vim.lsp.enable("zig")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if _G.enable_simple_colors then
        if client and client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      local opts = { silent = true, buffer = args.buf }

      vim.keymap.set("n", "g.", vim.lsp.buf.code_action, opts)

      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, opts)

      vim.keymap.set("n", "gd", function()
        -- local seen_lines = {}

        Snacks.picker.lsp_definitions({
          include_current = false,
        })
        -- Snacks.picker.lsp_definitions({
        --   auto_confirm = true,
        --   layout = { preview = true },
        --   filter = {
        --     filter = function(result)
        --       local key = ("%s:%d"):format(result.file, result.pos[1])
        --       if seen_lines[key] then
        --         return false
        --       end
        --       seen_lines[key] = true
        --       return true
        --     end,
        --   },
        -- })
      end, opts)

      vim.keymap.set("n", "gi", function()
        Snacks.picker.lsp_implementations({
          auto_confirm = true,
          layout = { preview = true },
        })
      end, opts)

      vim.keymap.set("n", "gr", function()
        Snacks.picker.lsp_references({
          include_current = false,
          layout = { preview = true },
        })
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
