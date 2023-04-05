local M = {}

M.setup = function()
  require('neo-tree').setup({
    use_default_mappings = false,
    filesystem = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    window = {
      mappings = {
        ['/'] = 'fuzzy_finder',
        ['<'] = 'prev_source',
        ['<cr>'] = 'open',
        ['>'] = 'next_source',
        ['?'] = 'show_help',
        ['A'] = 'add_directory',
        ['a'] = 'add',
        ['d'] = 'delete',
        ['m'] = 'move',
        ['o'] = 'open',
        ['r'] = 'rename',
      },
    },
  })

  -- enable easier jumping
  vim.keymap.set('n', '<C-S-j>', '<CMD>NeoTreeRevealToggle<CR>')
  vim.keymap.set('n', '<LEADER>j', '<CMD>NeoTreeReveal<CR>')
end

return M
