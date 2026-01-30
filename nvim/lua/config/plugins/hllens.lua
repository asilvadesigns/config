local M = {}

M.setup = function()
  require("hlslens").setup({ calm_down = false, })

  local kopts = { noremap = true, silent = true }

  vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)

  vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)

  vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)

  vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)

  vim.cmd("hi default link HlSearchNear CurSearch")
  vim.cmd("hi! link HlSearchLens Comment")
  vim.cmd("hi! link HlSearchLensNear Comment")

  -- vim.cmd("hi! link HlSearchLens DiagnosticVirtualTextHint")
  -- vim.cmd("hi! link HlSearchLensNear DiagnosticVirtualTextInfo")
end

return M
