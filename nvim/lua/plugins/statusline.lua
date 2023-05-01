return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
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
        sections = {
          lualine_a = {},
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {
          lualine_a = {},
          lualine_b = { { 'filename', path = 3 } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {},
        inactive_winbar = {
          lualine_a = {},
          lualine_b = { { 'filename', path = 3 } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
