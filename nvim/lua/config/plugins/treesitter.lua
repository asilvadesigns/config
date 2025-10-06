local M = {}

M.setup = function()
  require("nvim-treesitter").setup({})

  require("nvim-treesitter").install({
    "bash",
    "css",
    "dockerfile",
    "gitignore",
    "gleam",
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
    "prisma",
    "python",
    "regex",
    "scss",
    "swift",
    "templ",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  })

  vim.treesitter.language.register("markdown", "mdx")
  vim.treesitter.language.register("templ", "templ")
end

return M
