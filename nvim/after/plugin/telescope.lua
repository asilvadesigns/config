require('telescope').setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    mappings = { i = { ["<C-u>"] = false }, },
    sorting_strategy = "ascending",
  }
})

function project_files()
	local opts = {}
	local ok = pcall(require('telescope.builtin').git_files, opts)
	if not ok then require('telescope.builtin').find_files(opts) end
end

vim.keymap.set('n', '<leader>a', '<cmd>Telescope commands<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>f', '<cmd>lua project_files()<cr>')

