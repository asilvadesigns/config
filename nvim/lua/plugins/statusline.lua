-- @see: https://elianiva.my.id/post/neovim-lua-statusline/
-- @see: https://github.com/cseickel/dotfiles/blob/main/config/nvim/lua/status.lua
-- @see: https://nihilistkitten.me/nvim-lua-statusline/
local utils = require('core.utils')

local devicons = utils.get_plugin('nvim-web-devicons')
if not devicons then return end

-- local fugitive = utils.get_plugin('vim-fugitive')

local M = {}

local _cache = {}

M.get_icon = function()
  local ext = vim.fn.expand('%:e') -- file extension
  local key = vim.fn.expand('%:t') -- file name

  local cached = _cache[key]

  if not cached then
    local icon, color = devicons.get_icon(key, ext, { default = true })

    if vim.bo.filetype == '' then return '' end
    cached = '%#' .. color .. '# ' .. icon .. ' %*'
    _cache[key] = cached
  end

  return cached
end

-- M.get_mod = function()
--   return '%m'
-- end

_G.status = M

-- vim.opt.statusline = ' '
-- function statusline()
--   return table.concat({
--     '%#Normal# ',
--     '%{%v:lua.status.get_icon()%}',
--     '%#Normal#',
--     '%f',
--   })
-- end

vim.opt.statusline = ' '
-- vim.opt.winbar = '%{%v:lua.status.get_icon()%} %f'

-- NOTE: update winbar
-- TODO: doesn't work with telescope
-- vim.api.nvim_create_autocmd(
--   {
--     "BufFilePost",
--     "BufWinEnter",
--     "BufWritePost",
--     "BufEnter",
--     "UIEnter",
--     -- "CursorMoved",
--     -- "InsertEnter",
--   },
--   {
--     pattern = '*',
--     callback = function()
--       if (vim.bo.filetype == 'NvimTree') then
--         return
--       end
--
--       vim.api.nvim_set_option_value('winbar', ' %f', { scope = 'local' })
--     end
--   }
-- )
