local M = {}

M.setup = function()
  require('lualine').setup({
    options = {
      always_divide_middle = true,
      component_separators = { left = '', right = '' },
      disabled_filetypes = { statusline = {}, winbar = { 'NvimTree' } },
      globalstatus = true,
      icons_enabled = true,
      ignore_focus = {},
      refresh = { statusline = 100, tabline = 100, winbar = 100 },
      section_separators = { left = '', right = '' },
      theme = 'auto',
    },
    sections = {},
    winbar = {
      lualine_a = {},
      lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 3, color = 'LineNr' } },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {},
    inactive_winbar = {
      lualine_a = {},
      lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 3 } },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  })
end

return M
