local M = {}

M.setup = function()
  local function closeOthers()
    vim.cmd('only!')
  end

  require('auto-session').setup({
    log_level = 'error',
    -- pre_save_cmds = { 'CtrlSFClose', 'NvimTreeClose', 'TroubleClose' },
    pre_save_cmds = { closeOthers },
  })
end

return M
