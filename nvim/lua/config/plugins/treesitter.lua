local M = {}

local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "fish",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "rust",
  "scss",
  "swift",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zig",
}

local function parser_exists(lang)
  if type(lang) ~= "string" then
    return false
  end
  return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
end

M.setup = function()
  local plugin = require("nvim-treesitter")
  plugin.setup({})

  vim.defer_fn(function()
    plugin.install(parsers)
  end, 100)

  vim.treesitter.language.register("markdown", "mdc")
  vim.treesitter.language.register("markdown", "mdx")

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and parser_exists(lang) then
        pcall(vim.treesitter.start, args.buf, lang)
      end
    end,
  })
end

return M
