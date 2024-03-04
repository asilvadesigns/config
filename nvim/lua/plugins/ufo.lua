return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPre" }, -- was bufreadpre
  dependencies = {
    "kevinhwang91/promise-async",
    "luukvbaal/statuscol.nvim",
  },
  config = function()
    require("statuscol").setup({
      relculright = true,
      segments = {
        { text = { "%s " },                                      click = "v:lua.ScSa" },
        { text = { require("statuscol.builtin").lnumfunc, " " }, click = "v:lua.ScLa" },
        { text = { require("statuscol.builtin").foldfunc, " " }, click = "v:lua.ScFa" },
      },
    })

    require("ufo").setup({
      open_fold_hl_timeout = 0,
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,
}
