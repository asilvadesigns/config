return {
  "mfussenegger/nvim-lint",
  cmd = {
    "Lint",
    "LintWithBiome",
    "LintWithEslint",
  },
  opts = {
    linters = {
      biomejs = {
        condition = function(ctx)
          return vim.fs.find({ "biome.json" }, { path = ctx.filename, updward = true })[1]
        end,
      },
      eslint_d = {
        condition = function(ctx)
          return vim.fs.find(
            { ".eslintrc.cjs", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml" },
            { path = ctx.filename, updward = true }
          )[1]
        end,
      },
      luacheck = {
        condition = function(ctx)
          return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, updward = true })[1]
        end,
      },
    },
    linters_by_ft = {
      javascript = { "biomejs", "eslint_d" },
      javascriptreact = { "biomejs", "eslint_d" },
      lua = { "luacheck" },
      typescript = { "biomejs", "eslint_d" },
      typescriptreact = { "biomejs", "eslint_d" },
      svelte = { "biomejs", "eslint_d" },
      vue = { "biomejs", "eslint_d" },
    },
  },
  config = function()
    -- write logic to handle... getting nearest linter by filetype...
    -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    --
    -- vim.api.nvim_create_autocmd({
    --   "BufReadPost",
    --   "BufWritePost",
    --   "InsertLeave",
    -- }, {
    --   group = lint_augroup,
    --   callback = function()
    --     require("lint").try_lint()
    --   end,
    -- })

    vim.api.nvim_create_user_command("Lint", function()
      require("lint").try_lint()
    end, {})

    vim.api.nvim_create_user_command("LintWithBiome", function()
      require("lint").try_lint("biomejs")
    end, {})

    vim.api.nvim_create_user_command("LintWithEslint", function()
      require("lint").try_lint("eslint_d")
    end, {})
  end,
}
