local M = {}

M.setup = function()
  require("grug-far").setup({
    startInInsertMode = false,
    -- searchOnInsertLeave = true,
    keymaps = {
      replace = { n = "<localleader>r" },
      qflist = { n = "<localleader>q" },
      syncLocations = { n = "<localleader>s" },
      syncLine = { n = "<localleader>l" },
      close = { n = "<localleader>c" },
      historyOpen = { n = "<localleader>t" },
      historyAdd = { n = "<localleader>a" },
      refresh = { n = "<localleader>R" },
      openLocation = { n = "<localleader>o" },
      openNextLocation = { n = "<down>" },
      openPrevLocation = { n = "<up>" },
      gotoLocation = { n = "<enter>" },
      pickHistoryEntry = { n = "<enter>" },
      abort = { n = "<localleader>b" },
      help = { n = "g?" },
      toggleShowCommand = { n = "<localleader>p" },
      swapEngine = { n = "" },
    },
  })

  vim.cmd("hi! link GrugFarResultsMatch DiagnosticVirtualTextError")

  vim.api.nvim_create_user_command("GrugFarLocal", function()
    require("grug-far").open({
      prefills = {
        paths = vim.fn.expand("%"),
        search = "",
      },
    })
  end, {})

  vim.api.nvim_create_user_command("GrugFarGlobal", function()
    require("grug-far").open({
      prefills = {
        search = "",
      },
    })
  end, {})
end

return M
