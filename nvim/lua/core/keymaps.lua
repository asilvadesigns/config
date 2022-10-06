-- leader
vim.g.mapleader = ','

-- editing
vim.keymap.set('i', '<c-l>', '<END>')
vim.keymap.set('i', '<c-h>', '<HOME>')

-- navigation in buffers
vim.keymap.set('n', '<S-l>', ':bnext<cr>')
vim.keymap.set('n', '<S-h>', ':bprevious<cr>')
vim.keymap.set('n', '<leader>d', ':bdelete<cr>')

-- navigation in windows
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- navigation with mouse
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>')
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>')
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>')

-- indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
