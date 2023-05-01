local keymap_opts = { noremap = true }
local keymap_opts_with_expr = { noremap = true, expr = true }

-- better editing line movements
vim.keymap.set('i', '<c-l>', '<END>', keymap_opts)
vim.keymap.set('i', '<c-h>', '<HOME>', keymap_opts)

-- better escape using jk in insert and terminal mode
-- vim.keymap.set('i', 'kj', '<ESC>', defaults)
-- vim.keymap.set('t', 'kj', '<C-\\><C-n>', defaults)

-- better navigation in windows
vim.keymap.set('n', '<C-h>', '<C-w>h', keymap_opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', keymap_opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', keymap_opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', keymap_opts)
vim.keymap.set('n', '<leader>c', '<C-w>q', { noremap = true, desc = '[c]lose buffer'})

-- better navigation with mouse
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>', keymap_opts)
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>', keymap_opts)
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>', keymap_opts)

-- better navigation in line wraps
--vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
--vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)

-- better indent
vim.keymap.set('v', '<', '<gv', keymap_opts)
vim.keymap.set('v', '>', '>gv', keymap_opts)

-- paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dP', keymap_opts)

-- switch buffer
-- vim.keymap.set('n', '<S-h>', ':bprevious<CR>', keymap_opts)
-- vim.keymap.set('n', '<S-l>', ':bnext<CR>', keymap_opts)

-- move selected line / block of text in visual mode
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", keymap_opts)
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", keymap_opts)

-- resizing panes
vim.keymap.set('n', '<Left>', ':vertical resize +1<CR>', keymap_opts)
vim.keymap.set('n', '<Right>', ':vertical resize -1<CR>', keymap_opts)
vim.keymap.set('n', '<Up>', ':resize -1<CR>', keymap_opts)
vim.keymap.set('n', '<Down>', ':resize +1<CR>', keymap_opts)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

