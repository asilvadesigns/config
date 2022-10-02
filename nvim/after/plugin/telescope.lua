local ok, telescope = pcall(require,'telescope') 
if not ok then return end

require('telescope').setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      center = { height = 0.5, width = 0.8 }
    },
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

vim.keymap.set('n', '<LEADER>a', '<CMD>Telescope commands<CR>')
vim.keymap.set('n', '<LEADER>e', '<CMD>Telescope oldfiles<CR>')
vim.keymap.set('n', '<LEADER>f', '<CMD>lua project_files()<CR>')
vim.keymap.set('n', '<LEADER>a', '<CMD>Telescope commands<CR>')
vim.keymap.set('n', '<LEADER>b', '<CMD>Telescope buffers<CR>')
vim.keymap.set('n', '<LEADER>c', '<CMD>Telescope colorscheme<CR>')
vim.keymap.set('n', '<LEADER>e', '<CMD>Telescope oldfiles<CR>')
vim.keymap.set('n', '<LEADER>f', '<CMD>lua project_files()<CR>')
vim.keymap.set('n', '<LEADER>l', '<CMD>Telescope current_buffer_fuzzy_find<CR>')

