-- @see: https://elianiva.my.id/post/neovim-lua-statusline/
-- @see: https://github.com/cseickel/dotfiles/blob/main/config/nvim/lua/status.lua
-- @see: https://nihilistkitten.me/nvim-lua-statusline/
local utils = require('core.utils')
local icons = utils.get_plugin('nvim-web-devicons')

if not icons then return end

local M = {}

local _cache = {}

M.get_icon = function()
  local ext = vim.fn.expand("%:e") -- file extension
  local key = vim.fn.expand("%:t") -- file name

  local cached = _cache[key]

  if not cached then 
    local icon, color = icons.get_icon(key, ext, { default = true })

    if vim.bo.filetype == '' then return '' end
    cached = "%#" .. color .. "#" .. icon .. "%*"
    _cache[key] = cached
  end

  return cached
end

_G.status = M

vim.opt.statusline = ''
vim.opt.winbar = '    %{%v:lua.status.get_icon()%} %f'
