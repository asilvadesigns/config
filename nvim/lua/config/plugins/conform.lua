local M = {}

M.setup = function()
  ---@param originalTable table<string, string[]>
  ---@param keysToInclude string[]
  local filter_table = function(originalTable, keysToInclude)
    local resultTable = {}

    for _, key in ipairs(keysToInclude) do
      local value = originalTable[key]
      if value then
        resultTable[key] = value
      end
    end

    return resultTable
  end

  ---@param path_one string
  ---@param current_buffer string
  local get_distance_to = function(path_one, current_buffer)
    if path_one == nil then
      return math.huge
    end

    local common_prefix = ""
    local current_remaining = ""
    local other_remaining = ""

    for i = 1, math.min(#current_buffer, #path_one) do
      if current_buffer:sub(i, i) == path_one:sub(i, i) then
        common_prefix = common_prefix .. current_buffer:sub(i, i)
      else
        current_remaining = current_buffer:sub(i)
        other_remaining = path_one:sub(i)
        break
      end
    end

    -- Calculate the distance by counting directory separators
    local distance = 0

    for _ in current_remaining:gmatch("/") do
      distance = distance + 1
    end

    for _ in other_remaining:gmatch("/") do
      distance = distance + 1
    end

    return distance
  end

  ---@param _formatters table<string, string[]>
  ---@return string[] | nil
  local get_closest_formatter = function(_formatters)
    ---@type string
    local current_buffer_path = vim.api.nvim_buf_get_name(0)

    local available_formatters = require("conform").list_formatters(0)
    print("available!?")
    print(vim.inspect(available_formatters))

    local keys_to_include = {}
    for _, value in ipairs(available_formatters) do
      table.insert(keys_to_include, value.name)
    end
    ---@type table<string, string[]>
    _formatters = filter_table(_formatters, keys_to_include)

    ---@type table<string, number>
    local distance = {}

    for formatter_name, formatter_configs in pairs(_formatters) do
      local formatter_config_path = nil

      for _, v in ipairs(formatter_configs) do
        formatter_config_path = vim.fs.find(v, {
          path = current_buffer_path,
          stop = require("lspconfig.util").root_pattern(".git")(v),
          upward = true,
        })
      end

      if formatter_config_path[1] ~= nil then
        distance[formatter_name] = get_distance_to(formatter_config_path[1], current_buffer_path)
      end
    end

    ---@type string|nil
    local shortest_path_key = nil
    ---@type number
    local shortest_path_val = math.huge

    for formatter_name, formatter_distance in pairs(distance) do
      if formatter_distance < shortest_path_val then
        shortest_path_key = formatter_name
        shortest_path_val = formatter_distance
      end
    end

    if shortest_path_key == nil then
      return nil
    end

    return { shortest_path_key }
  end

  require("conform").setup({
    formatters_by_ft = {
      css = { "biome", "prettier", "stylelint" },
      go = { "goimports", "gofmt" },
      html = { "htmlbeautifier", "prettier" },
      javascript = { "biome", "prettier" },
      javascriptreact = { "biome", "prettier" },
      json = { "biome", "prettier" },
      jsonc = { "biome", "prettier" },
      lua = { "stylua" },
      sh = { "shellcheck", "shfmt" },
      sql = { "sql_formatter" },
      svelte = { "biome", "prettier" },
      templ = { "templ", "injected" },
      typescript = { "biome", "prettier" },
      typescriptreact = { "biome", "prettier" },
      vue = { "biome", "prettier" },
      yaml = { "biome", "prettier" },
    },
    formatters = {
      biome = {
        cwd = require("conform.util").root_file({ "biome.json" }),
        require_cwd = true,
        args = {
          "check",
          "--apply-unsafe",
          "--formatter-enabled=true",
          "--organize-imports-enabled=true",
          "--skip-errors",
          "--stdin-file-path",
          "$FILENAME",
        },
      },
    },
  })

  vim.api.nvim_create_user_command("Format", function()
    local conform = require("conform")
    local formatters = conform.list_formatters(0) -- 0 represents the current buffer

    if #formatters == 0 then
      vim.notify("No formatters available for this buffer, using lsp", vim.log.levels.WARN)
      conform.format({ async = false, lsp_format = "fallback" })
      return
    end

    local formatter_names = {}
    for _, formatter in ipairs(formatters) do
      table.insert(formatter_names, formatter.name)
    end

    local formatter_list = table.concat(formatter_names, ", ")
    vim.notify("Available formatters: " .. formatter_list, vim.log.levels.INFO)

    -- Invoke the formatter
    vim.notify("Should use: " .. formatter_names[1], vim.log.levels.INFO)
    conform.format({ async = false, lsp_format = "never", formatters = { formatter_names[1] } })
  end, {})

  -- vim.api.nvim_create_user_command("Format", function()
  --   -- get list of available formatters for the current buffer...
  --   -- then get the formatter files...
  --   local formatters = get_closest_formatter({
  --     ["biome"] = { "biome.json" },
  --     prettier = { ".prettierrc", "prettier.config.js" },
  --     stylua = { "stylua.toml" },
  --   })
  --
  --   if not formatters then
  --     -- TODO: at some point log out the lsp name
  --     print("formatter not found, using lsp")
  --     require("conform").format({ async = true, lsp_format = "prefer" })
  --   else
  --     print("formatted with " .. formatters[1])
  --     require("conform").format({ async = true, lsp_format = "never", formatters = formatters })
  --   end
  -- end, {})

  vim.api.nvim_create_user_command("FormatWithBiome", function()
    require("conform").format({ async = true, lsp_format = "never", formatters = { "biome-check" } })
  end, {})

  vim.api.nvim_create_user_command("FormatWithPrettier", function()
    require("conform").format({ async = true, lsp_format = "never", formatters = { "prettier" } })
  end, {})
end

return M
