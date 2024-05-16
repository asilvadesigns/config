return {
  "axelvc/template-string.nvim",
  enabled = true,
  event = { "InsertEnter" },
  config = function()
    require("template-string").setup({
      remove_template_string = true,
    })
  end,
}
