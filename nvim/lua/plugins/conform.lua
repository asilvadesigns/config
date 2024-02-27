---@param originalTable table<string, string>
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

local get_active_lsp = function()
  local clients = vim.lsp.get_active_clients()
  local clients_list = {}
  for _, client in pairs(clients) do
    table.insert(clients_list, client.name)
  end

  return clients_list
end

---@param _formatters table<string, string[]>
---@return string[] | nil
local get_closest_formatter = function(_formatters)
  ---@type string
  local current_buffer_path = vim.api.nvim_buf_get_name(0)
  print("current buffer path::" .. vim.inspect(current_buffer_path))

  local available_formatters = require("conform").list_formatters(0)
  local keys_to_include = {}
  for _, value in ipairs(available_formatters) do
    table.insert(keys_to_include, value.name)
  end
  _formatters = filter_table(_formatters, keys_to_include)

  ---@type table<string, number>
  local distance = {}

  --- NOTE: iterate over formatters, and collect their config paths.
  --- We are assuming that there will not be multiple formatters in one directory,
  --- and that there will not be multiple formatter configurations in on directory.
  for formatter_name, formatter_configs in pairs(_formatters) do
    ---@type table<string, string>
    local formatter_config_path = vim.fs.find(formatter_configs, {
      path = current_buffer_path,
      stop = vim.loop.os_homedir(),
      upward = true,
    })

    if formatter_config_path[1] ~= nil then
      distance[formatter_name] = get_distance_to(formatter_config_path[1], current_buffer_path)
    end
  end

  ---@type string
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
  event = { "VeryLazy" },
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
      formatters_by_ft = {
        css = { "biome-check", "prettier", "stylelint" },
        html = { "biome-check", "prettier" },
        javascript = { "biome-check", "prettier" },
        javascriptreact = { "biome-check", "prettier" },
        json = { "biome-check", "prettier" },
        jsonc = { "biome-check", "prettier" },
        lua = { "stylua" },
        sh = { "shellcheck", "shfmt" },
        svelte = { "biome-check", "prettier" },
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

      if not formatters then
        print("formatter not found, using lsp")
        require("conform").format({ async = true, lsp_fallback = true })
      else
        print("formatted with " .. formatters[1])
        require("conform").format({ async = true, formatters, lsp_fallback = false })
      end
    end, {})

    vim.api.nvim_create_user_command("FormatWithBiome", function()
      require("conform").format({
        async = true,
        formatters = { "biome-check" },
        lsp_fallback = false,
      })
    end, {})

    vim.api.nvim_create_user_command("FormatWithPrettier", function()
      require("conform").format({
        async = true,
        formatters = { "prettier" },
        lsp_fallback = false,
      })
    end, {})
  end,
}
