return {
  "mfussenegger/nvim-lint",
  event = { "VeryLazy" },
  cmd = { "Lint" },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      lua = { "luacheck" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      vue = { "eslint_d" },
    }

    vim.api.nvim_create_user_command("Lint", function()
      require("lint").try_lint()
    end, {})
  end,
}
