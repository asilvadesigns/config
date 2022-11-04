local M = {}

M.setup = function()
  local function closeOthers()
    vim.cmd('only!')
    vim.cmd('NeoTreeClose')
    vim.cmd('NvimTreeClose')
  end

  require('auto-session').setup({
    log_level = 'error',
    -- pre_save_cmds = { 'CtrlSFClose', 'NvimTreeClose', 'TroubleClose' },
    pre_save_cmds = { closeOthers },
  })
end

return M
