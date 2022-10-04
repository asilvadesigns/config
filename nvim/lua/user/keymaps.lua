local opts = { noremap = true, silent = true }

local normal = function(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end

local insert = function(lhs, rhs)
  vim.api.nvim_set_keymap('i', lhs, rhs, opts)
end

local visual = function(lhs, rhs)
  vim.api.nvim_set_keymap('v', lhs, rhs, opts)
end

-- leader
vim.g.mapleader = ','

-- editing
insert('<c-l>', '<END>')
insert('<c-h>', '<HOME>')

-- navigation in buffers
normal('<S-l>', ':bnext<cr>')
normal('<S-h>', ':bprevious<cr>')
normal('<leader>d', ':bdelete<cr>')

-- navigation in netrw
normal('<leader>e', ':Ex<cr>')
normal('<leader>j', ':Lex<cr>')
normal('<C-S-j>', ':Lex<cr>')

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
