local M = {}

M.get_packer = function()
  local fn = vim.fn
  local notify = vim.notify

  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    notify('Packer Bootstrap:: not found, downloading...')
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    notify('Packer Bootstrap:: done')
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

M.get_plugin = function(name)
  print('debug:: looking for', name)

  local ok, plugin = pcall(require, name)

  if (not ok) then
    vim.notify('WARN:: '..name..' config not used')
    return false, plugin
  end

  return true, plugin
end

return M

