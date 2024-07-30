local keymap_opts = { noremap = true, silent = true }
local keymap_opts_with_expr = { expr = true, noremap = true, silent = true }

-- kill search highlight
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlight" })

-- better editing line movements
vim.keymap.set("i", "<c-l>", "<END>", keymap_opts)
vim.keymap.set("i", "<c-h>", "<HOME>", keymap_opts)

-- better mouse navigation
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>", keymap_opts)
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>", keymap_opts)
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>", keymap_opts)
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>", keymap_opts)
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>", keymap_opts)
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>", keymap_opts)

-- NOTE: using smart splits
-- -- better window resize
-- vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- -- better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h", keymap_opts)
-- vim.keymap.set("n", "<C-j>", "<C-w>j", keymap_opts)
-- vim.keymap.set("n", "<C-k>", "<C-w>k", keymap_opts)
-- vim.keymap.set("n", "<C-l>", "<C-w>l", keymap_opts)
-- vim.keymap.set("n", "<leader>c", "<C-w>q", { noremap = true, desc = "[c]lose buffer" })
vim.keymap.set("n", "<leader>s", ":wa<CR>", keymap_opts)
vim.keymap.set("n", "<leader>wh", "<C-w>h", keymap_opts)
vim.keymap.set("n", "<leader>wj", "<C-w>j", keymap_opts)
vim.keymap.set("n", "<leader>wk", "<C-w>k", keymap_opts)
vim.keymap.set("n", "<leader>wl", "<C-w>l", keymap_opts)
vim.keymap.set("n", "<leader>wo", "<C-w>o", keymap_opts)
vim.keymap.set("n", "<leader>wq", "<C-w>q", keymap_opts)
vim.keymap.set("n", "<leader>ws", "<C-w>s", keymap_opts)
vim.keymap.set("n", "<leader>wv", "<C-w>v", keymap_opts)

vim.keymap.set("n", "<leader>wH", "<C-w>H", keymap_opts)
vim.keymap.set("n", "<leader>wJ", "<C-w>J", keymap_opts)
vim.keymap.set("n", "<leader>wK", "<C-w>K", keymap_opts)
vim.keymap.set("n", "<leader>wL", "<C-w>L", keymap_opts)

vim.keymap.set("n", "<leader>d", "<C-d>", keymap_opts)
vim.keymap.set("n", "<leader>u", "<C-u>", keymap_opts)

-- better keymaps
vim.keymap.set("n", "<leader>qf", function()
  if vim.bo.filetype == "NvimTree" then
    require("nvim-tree.api").tree.close()
  end

  if vim.bo.filetype == "oil" then
    require("oil").close()
  end

  vim.cmd(":wqa!<CR>")
end, keymap_opts)

-- -- better tab navigation
vim.keymap.set("n", "<", ":tabprevious<CR>", keymap_opts)
vim.keymap.set("n", ">", ":tabnext<CR>", keymap_opts)
vim.keymap.set("n", "tl", ":tablast<CR>", keymap_opts)
vim.keymap.set("n", "tn", ":tabnew<CR>", keymap_opts)
vim.keymap.set("n", "to", ":tabonly<CR>", keymap_opts)
vim.keymap.set("n", "tq", ":tabclose<CR>", keymap_opts)
vim.keymap.set("n", "<leader>1", ":tabn 1<CR>", keymap_opts)
vim.keymap.set("n", "<leader>2", ":tabn 2<CR>", keymap_opts)
vim.keymap.set("n", "<leader>3", ":tabn 3<CR>", keymap_opts)
vim.keymap.set("n", "<leader>4", ":tabn 4<CR>", keymap_opts)
vim.keymap.set("n", "<leader>5", ":tabn 5<CR>", keymap_opts)
vim.keymap.set("n", "<leader>6", ":tabn 6<CR>", keymap_opts)
vim.keymap.set("n", "<leader>7", ":tabn 7<CR>", keymap_opts)
vim.keymap.set("n", "<leader>8", ":tabn 8<CR>", keymap_opts)
vim.keymap.set("n", "<leader>9", ":tabn 9<CR>", keymap_opts)

-- better navigation in line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)
vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
vim.keymap.set("v", "j", "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)

-- better indent
vim.keymap.set("v", "<Tab>", ">gv", keymap_opts)
vim.keymap.set("v", "<S-Tab>", "<gv", keymap_opts)
--
-- vim.keymap.set('n', '>', [[<Cmd>echoe "Use [count]> instead"<CR>]])
-- vim.keymap.set('n', '<', [[<Cmd>echoe "Use [count]< instead"<CR>]])

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', keymap_opts)

-- switch buffer
-- vim.keymap.set('n', '<S-h>', ':bprevious<CR>', keymap_opts)
-- vim.keymap.set('n', '<S-l>', ':bnext<CR>', keymap_opts)

-- move selected line / block of text in visual mode
-- vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", keymap_opts)
-- vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", keymap_opts)
-- vim.keymap.set("n", "<leader>x", "<C-W>q", keymap_opts)

-- resizing panes
vim.keymap.set("n", "<C-S-H>", ":vertical resize +3<CR>", keymap_opts)
vim.keymap.set("n", "<C-S-L>", ":vertical resize -3<CR>", keymap_opts)
vim.keymap.set("n", "<C-S-J>", ":resize +3<CR>", keymap_opts)
vim.keymap.set("n", "<C-S-K>", ":resize -3<CR>", keymap_opts)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", keymap_opts)
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", keymap_opts)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", keymap_opts)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", keymap_opts)

-- easily exit insert mode in terminal
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
