local M = {}

M.setup = function()
  vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'WinSeparator' })
  vim.api.nvim_set_hl(0, 'LeapMatch', {
    fg = 'white', -- for light themes, set to 'black' or similar
    bold = true,
    nocombine = true,
  })

  require('leap').opts.highlight_unlabeled_phase_one_targets = true

  vim.keymap.set('n', ';', "<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>")
end

return M
