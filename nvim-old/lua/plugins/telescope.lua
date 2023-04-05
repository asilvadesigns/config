local M = {}
M.setup = function()
  require('telescope').setup({
    defaults = require('telescope.themes').get_dropdown({
      borderchars = {
        { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
        results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
      preview = false,
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<esc>'] = require('telescope.actions').close,
        },
      },
    }),
    extensions = {
      fzf = {
        case_mode = 'smart_case', -- or 'ignore_case', 'respect_case'
        fuzzy = true, -- false will only do exact matching
        override_file_sorter = true, -- override the file sorter
        override_generic_sorter = true, -- override the generic sorter
      },
    },
    pickers = {
      oldfiles = {
        only_cwd = true,
      },
    },
  })

  require('telescope').load_extension('fzf')

  vim.keymap.set('n', '<LEADER>a', ':Telescope commands<CR>')
  vim.keymap.set('n', '<LEADER>b', ':Telescope builtin<CR>')
  vim.keymap.set('n', '<LEADER>e', ':Telescope oldfiles<CR>')
  vim.keymap.set('n', '<LEADER>f', ':Telescope find_files<CR>')
  vim.keymap.set('n', '<LEADER>g', ':Telescope git_files<CR>')
end

return M
