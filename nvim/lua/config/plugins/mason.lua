---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  local servers = {
    "angularls",
    "astro",
    "clangd",
    "cssls", --good
    "dockerls",
    "eslint",
    "gopls", --good
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

  require("mason").setup({
    log_level = vim.log.levels.INFO,
    ui = { border = "rounded" },
  })

  --- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/cssls.lua
  vim.lsp.config.cssls = {
    capabilities = capabilities,
    cmd = {
      "vscode-css-language-server",
      "--stdio",
    },
    filetypes = {
      "css",
      "scss",
      "less",
    },
    init_options = {
      provideFormatter = true,
    },
    root_markers = {
      ".git",
      "package.json",
    },
    single_file_support = true,
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  }
  vim.lsp.enable("cssls")

  --- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/jsonls.lua
  vim.lsp.config.jsonls = {
    capabilities = capabilities,
    cmd = {
      "vscode-json-language-server",
      "--stdio",
    },
    filetypes = {
      "json",
      "jsonc",
    },
    init_options = {
      provideFormatter = true,
    },
    root_markers = {
      ".git",
      "package.json",
    },
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
  }
  vim.lsp.enable("jsonls")

  --- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/gopls.lua
  vim.lsp.config.gopls = {
    capabilities = capabilities,
    cmd = {
      "gopls",
    },
    filetypes = {
      "go",
      "gomod",
      "gowork",
      "gotmpl",
    },
    root_markers = {
      ".git",
      "go.mod",
      "go.sum",
    },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        completeUnimported = true,
        usePlaceholders = true,
      },
    },
  }
  vim.lsp.enable("gopls")

  --- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/html.lua
  vim.lsp.config.html = {
    cmd = {
      "vscode-html-language-server",
      "--stdio",
    },
    filetypes = {
      "html",
      "templ",
    },
    root_markers = {
      ".git",
      "package.json",
    },
    single_file_support = true,
    settings = {},
    init_options = {
      provideFormatter = true,
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      configurationSection = {
        "html",
        "css",
        "javascript",
      },
    },
  }

  --- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
  vim.lsp.config["lua_ls"] = {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
    },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
  vim.lsp.enable("lua_ls")


  --- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/tailwindcss.lua

  --- TODO: incomplete lsp configuration
  local volar_path = require("mason-registry").get_package("vue-language-server"):get_install_path()
  local home_path = vim.fn.expand("~")
  vim.lsp.config.ts_ls = {
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
  }
  -- vim.lsp.enable("ts_ls")

  --- TODO: incomplete lsp configuration
  local ts_path = require("mason-registry").get_package("typescript-language-server"):get_install_path()
  vim.lsp.config.volar = {
    capabilities = capabilities,
    init_options = {
      vue = {
        hybridMode = false,
      },
      typescript = {
        tsdk = ts_path .. "/node_modules/typescript/lib",
      },
    },
  }
  -- vim.lsp.enable("volar")

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
end

return M
