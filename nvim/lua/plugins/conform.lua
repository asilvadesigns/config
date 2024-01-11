return {
  "stevearc/conform.nvim",
  event = { "VeryLazy" },
  keys = {
    {
      "<leader>m",
      function()
        require("conform").format({ async = true, lsp_fallback = "always" })
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
      require("conform").format({ async = true, lsp_fallback = "always" })
    end, {})

    vim.api.nvim_create_user_command("FormatWithBiome", function()
      require("conform").format({ async = true, formatters = { "biome" } })
    end, {})

    vim.api.nvim_create_user_command("FormatWithPrettier", function()
      require("conform").format({ async = true, formatters = { "prettier" } })
    end, {})
  end,
}
