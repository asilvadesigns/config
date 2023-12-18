return {
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
              { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
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
    end,
  },
}
