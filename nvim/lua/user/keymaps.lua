local keys = vim.api.nvim_set_keymap
local opts = { silent = true }

vim.g.mapleader = ','

-- editing
keys('i', '<c-l>', '<END>', opts)
keys('i', '<c-h>', '<HOME>', opts)

-- mouse
keys('n', '<ScrollWheelUp>', '<C-y>', opts)
keys('n', '<ScrollWheelDown>', '<C-e>', opts)
keys('i', '<ScrollWheelUp>', '<C-y>', opts)
keys('i', '<ScrollWheelDown>', '<C-e>', opts)
keys('v', '<ScrollWheelUp>', '<C-y>', opts)
keys('v', '<ScrollWheelDown>', '<C-e>', opts)
