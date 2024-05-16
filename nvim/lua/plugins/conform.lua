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

return {
  "stevearc/conform.nvim",
  enabled = true,
  dependencies = { "neovim/nvim-lspconfig" },
  cmd = { "Format" },
  keys = {
    {
      "<leader>m",
      function()
        vim.cmd("Format")
      end,
      mode = "n",
    },
  },
  config = function()
    require("conform").setup({
      --- NOTE: table<filetype, table<formatter>>
      formatters_by_ft = {
        css = { "biome-check", "prettier", "stylelint" },
        go = { "goimports", "gofmt" },
        html = { "biome-check", "prettier" },
        javascript = { "biome-check", "prettier" },
        javascriptreact = { "biome-check", "prettier" },
        json = { "biome-check", "prettier" },
        jsonc = { "biome-check", "prettier" },
        lua = { "stylua" },
        sh = { "shellcheck", "shfmt" },
        sql = { "sql_formatter" },
        svelte = { "biome-check", "prettier" },
        templ = { "templ" },
        typescript = { "biome-check", "prettier" },
        typescriptreact = { "biome-check", "prettier" },
        vue = { "biome-check", "prettier" },
        yaml = { "biome-check", "prettier" },
      },
    })

    vim.api.nvim_create_user_command("Format", function()
      local formatters = get_closest_formatter({
        ["biome-check"] = { "biome.json" },
        prettier = { ".prettierrc", "prettier.config.js" },
        stylua = { "stylua.toml" },
      })

      print("formatting with::")
      print(vim.inspect(formatters))

      if not formatters then
        -- TODO: at some point log out the lsp name
        print("formatter not found, using lsp")
        require("conform").format({ async = true, lsp_fallback = true })
      else
        print("formatted with " .. formatters[1])
        require("conform").format({ async = true, lsp_fallback = false, formatters = formatters })
      end
    end, {})

    vim.api.nvim_create_user_command("FormatWithBiome", function()
      require("conform").format({ async = true, lsp_fallback = false, formatters = { "biome-check" } })
    end, {})

    vim.api.nvim_create_user_command("FormatWithPrettier", function()
      require("conform").format({ async = true, lsp_fallback = false, formatters = { "prettier" } })
    end, {})
  end,
}
