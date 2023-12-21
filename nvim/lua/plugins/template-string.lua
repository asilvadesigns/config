return {
  {
    "axelvc/template-string.nvim",
    event = { "InsertEnter" },
    opts = {
      remove_template_string = true, -- remove backticks when there are no template strings
    },
    ft = {
      "html",
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "python",
    },
  },
}
