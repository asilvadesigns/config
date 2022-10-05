local factory = function(mode)
  return function(lhs, rhs)
    return vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
  end
end

local normal = factory('n')
local insert = factory('i')
local visual = factory('v')

-- leader
vim.g.mapleader = ','

-- editing
insert('<c-l>', '<END>')
insert('<c-h>', '<HOME>')

-- navigation in buffers
normal('<S-l>', ':bnext<cr>')
normal('<S-h>', ':bprevious<cr>')
normal('<leader>d', ':bdelete<cr>')

-- navigation in windows
normal('<C-h>', '<C-w>h')
normal('<C-j>', '<C-w>j')
normal('<C-k>', '<C-w>k')
normal('<C-l>', '<C-w>l')

-- navigation with mouse
normal('<ScrollWheelUp>', '<C-y>')
normal('<ScrollWheelDown>', '<C-e>')
insert('<ScrollWheelUp>', '<C-y>')
insert('<ScrollWheelDown>', '<C-e>')
visual('<ScrollWheelUp>', '<C-y>')
visual('<ScrollWheelDown>', '<C-e>')

-- indent 
visual('v', '<', '<gv')
visual('v', '>', '>gv')
