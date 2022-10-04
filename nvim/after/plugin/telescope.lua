local ok, telescope = pcall(require, 'telescope')
if (not ok) then return end

telescope.setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = { center = { height = 0.5, width = 0.8 } },
    layout_strategy = 'center',
    mappings = { i = { ["<C-u>"] = false }, },
    sorting_strategy = "ascending",
  }
})

function project_files()
	local opts = {}
	local git_ok = pcall(require('telescope.builtin').git_files, opts)
	if not git_ok then require('telescope.builtin').find_files(opts) end
end

vim.keymap.set('n', '<leader>a', ':Telescope commands<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>c', ':Telescope colorscheme<CR>')
vim.keymap.set('n', '<leader>e', ':Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>f', ':lua project_files()<CR>')
vim.keymap.set('n', '<leader>l', ':Telescope current_buffer_fuzzy_find<CR>')
