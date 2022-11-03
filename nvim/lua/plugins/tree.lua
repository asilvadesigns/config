local M = {}

M.setup = function()
  require('nvim-tree').setup({
    actions = {
      open_file = {
        window_picker = {
          enable = false
        }
      }
    },
    update_cwd = false,
    -- git = {
    --   enable = false,
    --   ignore = true
    -- },
    -- respect_buf_cwd = true,
    -- update_focused_file = {
    --   enable = true,
    --   ignore_list = {},
    --   update_cwd = false,
    -- },
    renderer = {
      indent_width = 2,
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = "after",
      }
    },
    -- view = {
    --   hide_root_folder = true,
    --   width = 40
    -- },
  })

  -- enable easier jumping
  vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
  vim.keymap.set('n', '<LEADER>j', '<CMD>NvimTreeFindFile<CR>')

  -- enable indent lines like comments
  vim.cmd('highlight! link NvimTreeIndentMarker Comment')

  -- enable looking like normal window
  vim.cmd('highlight! clear NvimTreeNormal')
  vim.cmd('highlight! clear NvimTreeVertSplit')
  vim.cmd('highlight! clear NvimTreeEndOfBuffer')
end

return M
