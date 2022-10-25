local utils = require('core.utils')

local tree = utils.get_plugin('nvim-tree')
if (not tree) then return end

tree.setup({
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    ignore_list = {},
    update_cwd = false,
  },
  git = {
    enable = false,
    ignore = false
  },
  view = { width = 40 },
})

vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
vim.keymap.set('n', '<LEADER>j', '<CMD>NvimTreeFindFile<CR>')
