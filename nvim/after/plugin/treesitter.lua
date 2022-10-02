local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not ok) then return end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "css",
    "fish",
    "html",
    "json",
    "lua",
    "php",
    "swift",
    "toml",
    "tsx",
    "yaml",
  },
  autotag = {
    enable = true,
  },
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
