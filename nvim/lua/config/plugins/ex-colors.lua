local M = {}

M.setup = function()
  require("ex-colors").setup({
    included_patterns = require("ex-colors.presets").recommended.included_patterns + {
      "@constructor.lua",
      "@lsp.type.parameter.typescriptreact",
      "@tag.builtin.tsx",
      "@variable.builtin",
      "@variable.parameter",
      "^GrugFar",
      "^NvimTree",
      "^Snacks",
      "^Treesitter",
      "^TreesitterContext",
      "^VisiMatch",
      "^WVisiMatch",
    },
  })
end

return M
