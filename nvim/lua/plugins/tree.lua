local utils = require('core.utils')

local tree = utils.get_plugin('nvim-tree')
if (not tree) then return end

tree.setup({
  git = {
    enable = true,
    ignore = true
  },
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    ignore_list = {},
    update_cwd = false,
  },
  renderer = {
    indent_width = 1,
    indent_markers = {
      enable = false,
    },
    icons = {
      git_placement = "after",
    }
  },
  view = {
    hide_root_folder = true,
    width = 40
  },
})

vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
vim.keymap.set('n', '<LEADER>j', '<CMD>NvimTreeFindFile<CR>')
