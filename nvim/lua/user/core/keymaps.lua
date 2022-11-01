local defaults = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- better editing line movements
vim.keymap.set('i', '<c-l>', '<END>', defaults)
vim.keymap.set('i', '<c-h>', '<HOME>', defaults)

-- better escape using jk in insert and terminal mode
vim.keymap.set("i", "kj", "<ESC>", defaults)
vim.keymap.set("t", "kj", "<C-\\><C-n>", defaults)

-- center search results
vim.keymap.set("n", "n", "nzz", defaults)
vim.keymap.set("n", "N", "Nzz", defaults)

-- better navigation in windows
vim.keymap.set('n', '<C-h>', '<C-w>h', defaults)
vim.keymap.set('n', '<C-j>', '<C-w>j', defaults)
vim.keymap.set('n', '<C-k>', '<C-w>k', defaults)
vim.keymap.set('n', '<C-l>', '<C-w>l', defaults)

-- better navigation with mouse
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>', defaults)
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>', defaults)
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>', defaults)
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>', defaults)
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>', defaults)
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>', defaults)

-- better navigation in line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- better indent
vim.keymap.set("v", "<", "<gv", defaults)
vim.keymap.set("v", ">", ">gv", defaults)

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', defaults)

-- switch buffer
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", defaults)
vim.keymap.set("n", "<S-l>", ":bnext<CR>", defaults)

-- cancel search highlighting with ESC
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", defaults)

-- move selected line / block of text in visual mode
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", defaults)
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", defaults)

-- resizing panes
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", defaults)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", defaults)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", defaults)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", defaults)
