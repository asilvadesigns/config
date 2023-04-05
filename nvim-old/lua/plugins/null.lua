local M = {}

M.setup = function()
  require('null-ls').setup({
    sources = {
      -- eslint
      require('null-ls').builtins.code_actions.eslint,
      -- lua
      require('null-ls').builtins.diagnostics.luacheck,
      require('null-ls').builtins.formatting.stylua,
      -- prettier
      require('null-ls').builtins.formatting.prettier,
    },
  })
end

return M
