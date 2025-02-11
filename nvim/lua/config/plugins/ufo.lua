local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("ufo").setup({
    open_fold_hl_timeout = 0,
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

  vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
  vim.keymap.set("n", "]f", require("ufo").goNextClosedFold)
  vim.keymap.set("n", "[f", require("ufo").goPreviousClosedFold)

  vim.keymap.set("n", "zp", function()
    require("ufo.preview"):peekFoldedLinesUnderCursor()
  end)
end

return M
