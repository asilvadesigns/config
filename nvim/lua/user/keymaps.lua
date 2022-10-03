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
normal('<S-l>', ':bnext<CR>')
normal('<S-h>', ':bprevious<CR>')
normal('<leader>d', ':bdelete<CR>')

-- navigation in windows
normal('<C-h>', '<C-w>h')
normal('<C-j>', '<C-w>j')
normal('<C-k>', '<C-w>k')
normal('<C-l>', '<C-w>l')

-- TODO: extract to require('nvim-tree') module
-- navigation in tree
normal('<C-S-j>', ':NvimTreeToggle<cr>')
normal('<leader>j', ':NvimTreeFindFile<cr>')

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
