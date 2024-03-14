return {
  "kevinhwang91/nvim-ufo",
  lazy = false,
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { " ", require("statuscol.builtin").lnumfunc, " " }, click = "v:lua.ScLa" },
            { text = { " ", require("statuscol.builtin").foldfunc, " " }, click = "v:lua.ScFa" },
          },
        })
      end,
    },
  },
  config = function()
    require("ufo").setup({
      open_fold_hl_timeout = 0,
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
}
