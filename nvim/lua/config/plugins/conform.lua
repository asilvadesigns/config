local M = {}

local formatter_data = {
  prettier = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
  },
  eslint = {
    ".eslintrc",
    ".eslintrc.json",
    "eslint.config.mjs",
  },
  ["biome-check"] = {
    "biome.json",
    "biome.jsonc",
  },
}

M.setup = function()
  require("conform").setup({
    formatters_by_ft = {
      css = { "biome-check", "prettier", "stylelint" },
      go = { "goimports", "gofmt" },
      html = { "htmlbeautifier", "prettier" },
      javascript = { "biome-check", "prettier" },
      javascriptreact = { "biome-check", "prettier" },
      json = { "biome-check", "prettier" },
      jsonc = { "biome-check", "prettier" },
      lua = { "stylua" },
      sh = { "shellcheck", "shfmt" },
      sql = { "sql_formatter" },
      svelte = { "biome-check", "prettier" },
      templ = { "templ", "injected" },
      typescript = { "biome-check", "prettier" },
      typescriptreact = { "biome-check", "prettier" },
      vue = { "biome-check", "prettier" },
      yaml = { "biome-check", "prettier" },
    },
  })

  local function find_closest_config_file(config_names, current_file)
    if config_names == nil then
      return nil
    end
    for _, config_name in ipairs(config_names) do
      local found = vim.fs.find(config_name, { upward = true, path = vim.fn.fnamemodify(current_file, ":p:h") })
      if #found > 0 then
        return found[1] -- Return the closest config file found
      end
    end
    return nil -- No config file found
  end

  vim.api.nvim_create_user_command("Format", function()
    local conform = require("conform")
    local formatters = conform.list_formatters(0)
    local current_file = vim.api.nvim_buf_get_name(0)

    if #formatters == 0 then
      vim.notify("No formatters available for this buffer, using lsp", vim.log.levels.WARN)
      conform.format({ async = false, lsp_format = "fallback" })
      return
    end

    local formatter_to_use = nil
    for _, formatter in ipairs(formatters) do
      local config_file = find_closest_config_file(formatter_data[formatter.name], current_file)
      if config_file then
        formatter_to_use = formatter.name
        break
      end
    end

    if not formatter_to_use then
      formatter_to_use = formatters[1].name -- Fallback to the first available formatter
      vim.notify("Using formatter: " .. formatter_to_use, vim.log.levels.INFO)
    end

    vim.notify("Using formatter: " .. formatter_to_use, vim.log.levels.INFO)
    conform.format({ async = false, lsp_format = "never", formatters = { formatter_to_use } })
  end, {})

  vim.api.nvim_create_user_command("FormatWithBiome", function()
    require("conform").format({ async = true, lsp_format = "never", formatters = { "biome-check" } })
  end, {})

  vim.api.nvim_create_user_command("FormatWithPrettier", function()
    require("conform").format({ async = true, lsp_format = "never", formatters = { "prettier" } })
  end, {})
end

return M
