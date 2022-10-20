local utils = require('core.utils')

local telescope = utils.get_plugin('telescope')
if (not telescope) then return end

telescope.setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      center = { height = 0.5, width = 0.8 }
    },
    layout_strategy = 'center',
    mappings = { i = { ["<C-u>"] = false }, },
    sorting_strategy = "ascending",
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case", "respect_case"
    }
  }
})

telescope.load_extension('fzf')

local no_preview = function()
  return require('telescope.themes').get_dropdown({
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
    width = 0.8,
    previewer = false,
    prompt_title = false
  })
end

local get_buffers = function()
  require('telescope.builtin').buffers(no_preview())
end

local get_commands = function()
  require('telescope.builtin').commands(no_preview())
end

local get_files = function()
  local opts = no_preview()
  local git_ok = pcall(require('telescope.builtin').git_files, opts)
  if not git_ok then require('telescope.builtin').find_files(opts) end
end

local get_recent = function()
  require('telescope.builtin').oldfiles(no_preview())
end

vim.keymap.set('n', '<LEADER>a', get_commands)
vim.keymap.set('n', '<LEADER>b', get_buffers)
vim.keymap.set('n', '<LEADER>e', get_recent)
vim.keymap.set('n', '<LEADER>f', get_files)
vim.keymap.set('n', '<LEADER>l', '<CMD>Telescope current_buffer_fuzzy_find<CR>')
