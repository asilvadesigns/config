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

M.setup = function()
  local ts = require("nvim-treesitter")
  ts.setup({})

  -- Install parsers asynchronously
  vim.defer_fn(function()
    ts.install(parsers)
  end, 100)

  vim.treesitter.language.register("markdown", "mdc")
  vim.treesitter.language.register("markdown", "mdx")

  -- Enable treesitter highlighting for supported filetypes
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local ft = args.match
      local lang = vim.treesitter.language.get_lang(ft)
      if lang then
        pcall(vim.treesitter.start, args.buf, lang)
      end
    end,
  })
end

return M
