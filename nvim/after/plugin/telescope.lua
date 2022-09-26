project_files = function()
	local opts = {}
	local ok = pcall(require('telescope.builtin').git_files, opts)
	if not ok then require('telescope.builtin').find_files(opts) end
end

vim.keymap.set('n', '<leader>e', '<cmd>lua project_files()<cr>')

