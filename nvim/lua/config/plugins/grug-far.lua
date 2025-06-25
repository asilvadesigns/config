local M = {}

M.setup = function()
  local grugfar = require("grug-far")

  grugfar.setup({
    startInInsertMode = true,
    windowCreationCommand = "vsplit",
    resultsHighlight = true,
    inputsHighlight = false,
    maxLineLength = 200,
    keymaps = {
      abort = { n = "<localleader>b" },
      close = { n = "<localleader>c" },
      gotoLocation = { n = "<enter>" },
      help = { n = "g?" },
      historyAdd = { n = "<localleader>a" },
      historyOpen = { n = "<localleader>h" },
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
    prefills = {
      flags = "-U",
    },
    folding = {
      enabled = vim.o.foldenable,
      foldcolumn = vim.o.foldcolumn,
      foldlevel = vim.o.foldlevel,
    },
    wrap = false,
  })

  vim.cmd("hi! link GrugFarHelpWinActionDescription Comment")
  vim.cmd("hi! link GrugFarInputLabel String")
  vim.cmd("hi! link GrugFarInputPlaceholder DiagnosticVirtualTextInfo")
  vim.cmd("hi! link GrugFarResultsMatch DiffText")
  vim.cmd("hi! link GrugFarResultsMatchAdded NeogitDiffAdd")
  vim.cmd("hi! link GrugFarResultsMatchRemoved NeogitDiffDelete")

  ---@param options grug.far.OptionsOverride
  local function toggle(options)
    if grugfar.has_instance(options.instanceName) then
      if options.prefills ~= nil then
        grugfar.get_instance(options.instanceName):update_input_values(options.prefills, false)
      end
      grugfar.get_instance(options.instanceName):open()
    else
      grugfar.toggle_instance(options)
    end
  end

  vim.api.nvim_create_user_command("SearchFile", function()
    toggle({
      instanceName = _G.grug_instance_local,
      prefills = { paths = vim.fn.expand("%") },
    })
  end, {})

  vim.api.nvim_create_user_command("SearchFileVisual", function()
    toggle({
      instanceName = _G.grug_instance_local,
      prefills = {
        paths = vim.fn.expand("%"),
        search = grugfar.get_current_visual_selection(),
      },
    })
  end, { range = true })

  vim.api.nvim_create_user_command("SearchProject", function()
    toggle({
      instanceName = _G.grug_instance_global,
    })
  end, {})

  vim.api.nvim_create_user_command("SearchProjectVisual", function()
    toggle({
      instanceName = _G.grug_instance_global,
      prefills = {
        paths = "",
        search = grugfar.get_current_visual_selection(),
      },
    })
  end, { range = true })
end

return M
