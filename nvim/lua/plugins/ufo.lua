return {
  "kevinhwang91/nvim-ufo",
  event = { "VeryLazy" },
  dependencies = {
    "kevinhwang91/promise-async",
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
  opts = {
    open_fold_hl_timeout = 0,
    provider_selector = function(_, filetype, buftype)
      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
        or function(bufnr)
          return require("ufo")
            .getFolds(bufnr, "lsp")
            :catch(function(err)
              return handleFallbackException(bufnr, err, "treesitter")
            end)
            :catch(function(err)
              return handleFallbackException(bufnr, err, "indent")
            end)
        end
    end,
  },
}
