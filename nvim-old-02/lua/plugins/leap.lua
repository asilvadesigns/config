local utils = require('core.utils')

local leap = utils.get_plugin('leap')
if not leap then return end

vim.keymap.set('n', ';', "<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>")
