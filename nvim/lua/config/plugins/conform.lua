local M = {}

M.setup = function()
  require("conform").setup({
    formatters_by_ft = {
      css = { { "biome-check", "prettier", "stylelint" } },
      go = { "goimports", "gofmt" },
      html = { { "biome-check", "prettier" } },
      javascript = { { "biome-check", "prettier" } },
      javascriptreact = { { "biome-check", "prettier" } },
      json = { { "biome-check", "prettier" } },
      jsonc = { { "biome-check", "prettier" } },
      lua = { "stylua" },
      sh = { { "shellcheck", "shfmt" } },
      sql = { "sql_formatter" },
      svelte = { { "biome-check", "prettier" } },
      templ = { { "templ", "injected" } },
      typescript = { { "biome-check", "prettier" } },
      typescriptreact = { { "biome-check", "prettier" } },
      vue = { { "biome-check", "prettier" } },
      yaml = { { "biome-check", "prettier" } },
    },
  })

  vim.api.nvim_create_user_command("Format", function()
    local fmts = require("conform").list_formatters_for_buffer(0)[1]
    local fmt = fmts[1]
    print("available formatters::" .. vim.inspect(fmts))

    local msg = "formatting with lsp"
    if fmt ~= nil then
      msg = ("formatting with %s"):format(fmt, vim.api.nvim_buf_get_name(0))
    end

    vim.notify(msg, vim.log.levels.INFO)
    require("conform").format({ async = true, lsp_fallback = true })
  end, {})

  vim.api.nvim_create_user_command("FormatWithBiome", function()
    require("conform").format({ async = true, lsp_fallback = false, formatters = { "biome-check" } })
  end, {})

  vim.api.nvim_create_user_command("FormatWithPrettier", function()
    require("conform").format({ async = true, lsp_fallback = false, formatters = { "prettier" } })
  end, {})
end

return M
