vim.g.mapleader = ","

-- KEYMAPS | EDITING
vim.keymap.set('i', '<c-l>', '<END>')         -- jump to end
vim.keymap.set('i', '<c-h>', '<HOME>')        -- jump to start

-- KEYMAPS | MOUSE
vim.opt.mouse = 'a'                 -- enable mouse support
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>')
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>')
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>')

-- KEYMAPS | SYSTEM
vim.keymap.set('n', '<c-r>', '<cmd>luafile $MYVIMRC<cr>')

