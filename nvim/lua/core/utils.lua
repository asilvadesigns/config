local M = {}

local state = {
  should_sync = false,
  last_buf = ''
}

M.get_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  local is_not_installed = vim.fn.empty(vim.fn.glob(install_path)) > 0

  if is_not_installed then
    vim.notify('Packer not found! Downloading...')
    vim.api.nvim_command('! git clone https://github.com/wbthomason/packer.nvim --depth=1 ' .. install_path)
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

-- isolated module START
local tool_windows = {
  NvimTree = true,
  Trouble = true,
  qf = true,
}

M.get_prev = function()
  if (tool_windows[vim.bo.filetype]) then
    vim.cmd("execute bufwinnr(" .. state.last_buf .. ") 'wincmd w'")
  end
end

M.set_prev = function()
  if (not tool_windows[vim.bo.filetype]) then
    state.last_buf = vim.api.nvim_exec('echo bufnr()', true)
  end
end
-- isolated module END

return M
