return {
  "axelvc/template-string.nvim",
  event = { "VeryLazy" },
  config = function()
    require("template-string").setup({
      remove_template_string = true,
    })
  end,
}
