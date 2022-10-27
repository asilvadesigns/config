local utils = require('core.utils')

local lualine = utils.get_plugin('lualine')
if not lualine then return end

local statusline = {
  lualine_a = {},
  lualine_b = { 'branch' },
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

local winbar = {
  lualine_a = {},
  lualine_b = { { 'filetype', icon_only = true }, 'filename' },
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
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
  -- statusline
  sections = statusline,
  inactive_sections = statusline,
  -- winbar
  winbar = winbar,
  inactive_winbar = winbar,
})
