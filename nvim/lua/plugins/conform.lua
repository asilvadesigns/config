return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>m",
        function()
          require("conform").format({ async = true })
        end,
        mode = "n",
        desc = "For[m]at",
      },
    },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
      formatters_by_ft = {
        css = { "stylelint", "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        sh = { "shellcheck", "shfmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },
}
