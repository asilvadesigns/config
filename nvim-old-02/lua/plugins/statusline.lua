local utils = require('core.utils')

local lualine = utils.get_plugin('lualine')
if not lualine then return end

-- local statusline = {
--   lualine_a = {},
--   lualine_b = { 'branch' },
--   lualine_c = {},
--   lualine_x = {},
--   lualine_y = {},
--   lualine_z = {}
-- }

local statusline = {}

local winbar = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { { 'filetype', icon_only = true }, { 'filename', path = 3 } },
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
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  -- statusline
  sections = statusline,
  inactive_sections = statusline,
  -- winbar
  winbar = winbar,
  inactive_winbar = winbar,
})
