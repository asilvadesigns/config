local M = {}

M.setup = function()
  local ufo = require("ufo")

  ---@diagnostic disable-next-line: missing-fields
  ufo.setup({
    open_fold_hl_timeout = 0,
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
    preview = {
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
        jumpTop = "[",
        jumpBot = "]",
        switch = "<Tab>", -- super cool, use this to jump into floating window
      },
    },
  })

  vim.keymap.set("n", "zR", ufo.openAllFolds)
  vim.keymap.set("n", "zM", ufo.closeAllFolds)
  vim.keymap.set("n", "zm", ufo.closeFoldsWith)
  vim.keymap.set("n", "]f", ufo.goNextClosedFold)
  vim.keymap.set("n", "[f", ufo.goPreviousClosedFold)

  vim.keymap.set("n", "zp", function()
    require("ufo.preview"):peekFoldedLinesUnderCursor()
  end)
end

return M
