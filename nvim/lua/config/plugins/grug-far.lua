local M = {}

M.setup = function()
  require("grug-far").setup({
    -- disableBufferLineNumbers = true,
    -- normalModeSearch = true,
    -- startInInsertMode = false,
    -- maxSearchMatches = 500,
    -- engine = "astgrep",
    resultsHighlight = false,
    inputsHighlight = false,
    keymaps = {
      abort = { n = "<localleader>b" },
      close = { n = "<localleader>c" },
      gotoLocation = { n = "<enter>" },
      help = { n = "g?" },
      historyAdd = { n = "<localleader>a" },
      historyOpen = { n = "<localleader>t" },
      openLocation = { n = "<localleader>o" },
      openNextLocation = { n = "<down>" },
      openPrevLocation = { n = "<up>" },
      pickHistoryEntry = { n = "<enter>" },
      qflist = { n = "<localleader>q" },
      refresh = { n = "<localleader>R" },
      replace = { n = "<localleader>r" },
      swapEngine = { n = "" },
      syncLine = { n = "<localleader>l" },
      syncLocations = { n = "<localleader>s" },
      toggleShowCommand = { n = "<localleader>p" },
    },
    -- folding = {
    --   enabled = vim.o.foldenable,
    --   foldcolumn = vim.o.foldcolumn,
    --   foldlevel = vim.o.foldlevel,
    -- },
    -- wrap = false,
  })

  vim.cmd("hi! link GrugFarInputLabel String")
  vim.cmd("hi! link GrugFarResultsMatch DiffText")
  vim.cmd("hi! link GrugFarResultsMatchRemoved NeogitDiffDelete")
  vim.cmd("hi! link GrugFarResultsMatchAdded NeogitDiffAdd")

  vim.api.nvim_create_user_command("GrugFarLocal", function()
    require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
  end, {})
end

return M
