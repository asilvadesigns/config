local keys = vim.keymap.set
local opts = { silent = true }

local ok, saga = pcall(require, 'lspsaga')
if (not ok) then return end

saga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keys("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Code action
keys({"n","v"}, "<C>.", "<cmd>Lspsaga code_action<CR>", opts)

-- Rename
keys("n", "gr", "<cmd>Lspsaga rename<CR>", opts)

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keys("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)

-- Show line diagnostics
keys("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show cursor diagnostic
keys("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Diagnsotic jump can use `<c-o>` to jump back
keys("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keys("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Only jump to error
keys("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keys("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Outline
keys("n","<leader>o", "<cmd>LSoutlineToggle<CR>",opts)

-- Hover Doc
keys("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

-- Float terminal
keys("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", opts)
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keys("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", opts)
-- close floaterm
keys("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
