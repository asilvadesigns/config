local M = {}

M.setup = function()
  -- Load lspconfig to register server configurations
  require("lspconfig")

  --- Biome
  vim.lsp.config('biome', {})
  vim.lsp.enable("biome")

  --- C/C++
  vim.lsp.config('clangd', {
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })
  vim.lsp.enable("clangd")

  --- CSS
  vim.lsp.config('cssls', {
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
  })
  vim.lsp.enable("cssls")

  --- HTML
  vim.lsp.config('html', {
    filetypes = { "html", "templ" },
  })
  vim.lsp.enable("html")

  --- JSON
  local jsonok, schemastore = pcall(require, "schemastore")
  if jsonok then
    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      },
    })
    vim.lsp.enable("jsonls")
  end

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
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = {
            vim.fn.expand("/opt/homebrew/share/xmake/scripts/"),
          },
        },
        telemetry = { enable = false },
      },
    },
  })
  vim.lsp.enable("lua_ls")

  --- RUST
  vim.lsp.config('rust_analyzer', {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = true,
        check = {
          command = "clippy",
        },
      },
    },
  })
  vim.lsp.enable('rust_analyzer')


  --- TAILWIND
  vim.lsp.config("tailwindcss", {
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "go", "templ" },
    settings = {
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

  --- SWIFT
  vim.lsp.config("sourcekit", {
    filetypes = { "swift" },
  })
  vim.lsp.enable("sourcekit")

  --- ZIG
  vim.lsp.config("zls", {})
  vim.lsp.enable("zls")

  --- LSP Attach keymaps
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        client.server_capabilities.semanticTokensProvider = nil
      end

      local opts = { silent = true, buffer = args.buf }

      vim.keymap.set("n", "g.", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, opts)

      vim.keymap.set("n", "gd", function()
        Snacks.picker.lsp_definitions({ include_current = false })
      end, opts)

      vim.keymap.set("n", "gi", function()
        Snacks.picker.lsp_implementations({ auto_confirm = true, layout = { preview = true } })
      end, opts)

      vim.keymap.set("n", "gr", function()
        Snacks.picker.lsp_references({ include_current = false, layout = { preview = true } })
      end, opts)
    end,
  })
end

return M
