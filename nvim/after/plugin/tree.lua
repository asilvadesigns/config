require('nvim-tree').setup({
  update_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    ignore_list = {},
    update_cwd = true,
  },
  view = { width = 40 },
})

vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
vim.keymap.set('n', '<LEADER>j', '<CMD>NvimTreeFindFile<CR>')

