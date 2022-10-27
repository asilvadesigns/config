local utils = require('core.utils')

local lualine = utils.get_plugin('lualine')
if not lualine then return end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {
        'NvimTree',
        'Trouble'
      },
      winbar = {
        'NvimTree',
        'Trouble'
      },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {},
  inactive_sections = {},
  tabline = {},
  winbar = {
    lualine_a = {},
    lualine_b = { { 'filetype', icon_only = true }, 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = { { 'filetype', icon_only = true }, 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
})
