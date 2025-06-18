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
    "tailwindcss",
    "taplo",
    "templ",
    "vtsls",
    "yamlls",
  }

  local formatters = {
    "htmlbeautifier",
    "prettier",
    "sql-formatter",
    "stylua",
  }

  require("mason").setup({
    ui = {
      border = "rounded",
      backdrop = 100,
    },
  })

  require("lspconfig").clangd.setup({})

  require("lspconfig").cssls.setup({
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

  local htmldefaults = require("lspconfig.configs.html").default_config
  require("lspconfig").html.setup({
    filetypes = vim.list_extend({ "templ" }, htmldefaults.filetypes),
  })

  -- NOTE: new schemas see here https://www.schemastore.org/json/
  require("lspconfig").jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  require("lspconfig").gopls.setup({
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

  require("lspconfig").lua_ls.setup({
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })

  local tailwind_defaults = require("lspconfig.configs.tailwindcss").default_config
  require("lspconfig").tailwindcss.setup({
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

  require("lspconfig").vtsls.setup({
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

  require("lspconfig").yamlls.setup({})

  require("lspconfig").postgres_lsp.setup({
    cmd = { "postgrestools", "lsp-proxy", "--config-path", vim.fn.getcwd() .. "/postgrestools.jsonc" },
    filetypes = { "sql", "postgres" },
    root_dir = require("lspconfig").util.root_pattern("postgrestools.jsonc"),
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
        Snacks.picker.lsp_definitions({ layout = { preview = true } })
      end, opts)

      vim.keymap.set("n", "gi", function()
        Snacks.picker.lsp_implementations({ layout = { preview = true } })
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
