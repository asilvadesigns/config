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
        css = { "biome", "prettier", "stylelint" },
        html = { "biome", "prettier" },
        javascript = { "biome", "prettier" },
        javascriptreact = { "biome", "prettier" },
        json = { "biome", "prettier" },
        jsonc = { "biome", "prettier" },
        lua = { "stylua" },
        sh = { "shellcheck", "shfmt" },
        svelte = { "biome", "prettier" },
        typescript = { "biome", "prettier" },
        typescriptreact = { "biome", "prettier" },
        vue = { "biome", "prettier" },
        yaml = { "biome", "prettier" },
      },
    })

    vim.api.nvim_create_user_command("Format", function()
      local current_buffer_path = vim.api.nvim_buf_get_name(0)

      local path_to_biome = vim.fs.find({ "biome.json" }, {
        path = current_buffer_path,
        stop = vim.loop.os_homedir(),
        upward = true,
      })

      local path_to_prettier = vim.fs.find({ ".prettierrc" }, {
        path = current_buffer_path,
        stop = vim.loop.os_homedir(),
        upward = true,
      })

      local get_distance_to = function(path_one, current_buffer)
        if (path_one == nil) then
          return math.huge
        end

        local common_prefix = ''
        local current_remaining = ''
        local other_remaining = ''

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

        for _ in current_remaining:gmatch('/') do
          distance = distance + 1
        end

        for _ in other_remaining:gmatch('/') do
          distance = distance + 1
        end

        return distance
      end

      local get_formatters_found = function(table)
        for _, value in pairs(table) do
          if value ~= math.huge then
            return true
          end
        end

        return false
      end

      local get_formatters_key = function(table)
        local smallest_key = nil

        for key, _ in pairs(table) do
          if smallest_key == nil or key < smallest_key then
            smallest_key = key
          end
        end

        return smallest_key
      end

      local distance = {}

      distance[get_distance_to(path_to_biome[1], current_buffer_path)] = { "biome" }
      distance[get_distance_to(path_to_prettier[1], current_buffer_path)] = { "prettier" }

      local formatter_found = get_formatters_found(distance)

      if (not formatter_found) then
        print('formatter not found, using lsp')
        require("conform").format({ async = true, lsp_fallback = true })
        return
      end

      local formatters = distance[get_formatters_key(distance)]

      print('formatting with...' .. formatters[1])
      require("conform").format({
        async = true,
        formatters = formatters,
        lsp_fallback = false,
      })
    end, {})

    vim.api.nvim_create_user_command("FormatWithBiome", function()
      require("conform").format({
        async = true,
        formatters = { "biome" },
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
