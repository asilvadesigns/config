local ok, lualine = pcall(require, 'lualine')
if (not ok) then return end

lualine.setup({
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  winbar = {
    lualine_a = { },
    lualine_b = { { 'filetype', icon_only = true }, 'filename' },
    lualine_c = { },
    lualine_x = {'encoding', 'fileformat' },
    lualine_y = {'progress'},
    lualine_z = { }
  },
  inactive_winbar = {
    lualine_a = { },
    lualine_b = { },
    lualine_c = { { 'filetype', icon_only = true }, 'filename' },
    lualine_x = {'encoding', 'fileformat' },
    lualine_y = {'progress'},
    lualine_z = { }
  },
  sections = {
    lualine_a = { },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {'%F'},
    lualine_x = { },
    lualine_y = { },
    lualine_z = { }
  },
})
