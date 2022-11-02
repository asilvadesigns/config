local M = {}

M.handle_complete = vim.schedule_wrap(function()
  vim.api.nvim_exec([[ doautocmd User Defer ]], false)
end)

M.setup = function()
  local packer_loaded = false
  local packer_install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  local packer_install_path_empty = vim.fn.empty(vim.fn.glob(packer_install_path)) > 0

  if packer_install_path_empty then
    vim.cmd('! git clone https://github.com/wbthomason/packer.nvim --depth=1 '..packer_install_path)
    packer_loaded = true
    vim.cmd([[packadd packer.nvim]])
  end

  local packer = require('packer')

  packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end,
    },
  })

  return packer_loaded, packer
end

return M

