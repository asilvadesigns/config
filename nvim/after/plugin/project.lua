require('project_nvim').setup({
  detection_methods = { "pattern" },
  patterns = { ".git" }
})
require('telescope').load_extension('projects')

vim.keymap.set('n', '<C-S-k>', '<CMD>Telescope projects<CR>')

