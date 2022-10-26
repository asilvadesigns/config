local utils = require('core.utils')

local telescope = utils.get_plugin('telescope')
if (not telescope) then return end

telescope.setup({
  defaults = {
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top'
    },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<esc>"] = require('telescope.actions').close
      },
    },
  },
  extensions = {
    fzf = {
      case_mode = "smart_case", -- or "ignore_case", "respect_case"
      fuzzy = true, -- false will only do exact matching
      override_file_sorter = true, -- override the file sorter
      override_generic_sorter = true, -- override the generic sorter
    }
  },
})

telescope.load_extension('fzf')

-- local get_files = function()
--   local opts = no_preview()
--   local git_ok = pcall(require('telescope.builtin').git_files, opts)
--   if not git_ok then require('telescope.builtin').find_files(opts) end
-- end

vim.keymap.set('n', '<LEADER>a', '<CMD>Telescope commands<CR>')
vim.keymap.set('n', '<LEADER>b', '<CMD>Telescope builtin<CR>')
vim.keymap.set('n', '<LEADER>e', '<CMD>Telescope oldfiles<CR>')
vim.keymap.set('n', '<LEADER>f', '<CMD>Telescope find_files<CR>')
