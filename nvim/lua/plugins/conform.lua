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
        css = { "stylelint", "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        sh = { "shellcheck", "shfmt" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        yaml = { "prettier" },
      },
    })

    vim.api.nvim_create_user_command("Format", function()
      require("conform").format({ async = true, lsp_fallback = "always" })
    end, {})
  end,
}
