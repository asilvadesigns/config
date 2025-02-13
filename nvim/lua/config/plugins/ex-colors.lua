local M = {}

M.setup = function()
  require("ex-colors").setup({
    included_patterns = require("ex-colors.presets").recommended.included_patterns + {
      "^GrugFar", --- %u
      "^NvimTree", --- %u
      "^Snacks", --- %u
      "^TreesitterContext", --- %u
      "^VisiMatch", --- %u
      "^WVisiMatch", --- %u
    },
  })
end

return M
