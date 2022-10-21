local M = {}

local state = {
  should_sync = false
}

M.get_packer = function()
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  local is_not_installed = vim.fn.empty(vim.fn.glob(install_path)) > 0

  if is_not_installed then
    vim.notify('Packer not found! Downloading...')
    vim.api.nvim_command('! git clone https://github.com/wbthomason/packer.nvim --depth=1 '..install_path)
    vim.notify('Packer done')
    vim.cmd [[packadd packer.nvim]]
    state.should_sync = true
  end

  vim.api.nvim_create_user_command('Reload', M.reload, {})

  return require('packer')
end

M.get_plugin = function(name)
  local ok, plugin = pcall(require, name)

  if not ok then
    return false
  end

  return plugin
end

M.get_state = function()
  return state
end

M.reload = function()
  require('packer').sync()
end

return M

