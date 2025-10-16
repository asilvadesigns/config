local M = {}

--- NOTE: https://github.com/dcloud/dotfiles/blob/c32b5c0ee79626d26ecb9a3bc887e1550d9ca292/config/nvim/lua/plugins/treesitter.lua#L47
M.setup = function()
  local plugin = require("nvim-treesitter")

  plugin.setup({})

  plugin.install({
    "bash",
    "c",
    "cpp",
    "css",
    "dockerfile",
    "fish",
    "gitignore",
    "gleam",
    "glsl",
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
    "tmux",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  })

  vim.treesitter.language.register("markdown", "mdx")
  vim.treesitter.language.register("templ", "templ")

  local available = plugin.get_available()

  local available_filetypes = vim
    .iter(available)
    :map(function(lang)
      return vim.treesitter.language.get_filetypes(lang)
    end)
    :flatten()
    :totable()

  -- vim.print(table.concat(available))
  -- vim.print(table.concat(available_filetypes))

  vim.api.nvim_create_autocmd("FileType", {
    pattern = available_filetypes,
    callback = function()
      vim.treesitter.start()
    end,
  })
end

return M
