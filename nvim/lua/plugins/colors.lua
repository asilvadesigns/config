return {
  {
    'ishan9299/nvim-solarized-lua',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme solarized-flat')
      vim.cmd('hi EndOfBuffer guifg=bg')
      vim.cmd('hi WinSeparator guifg=bg')

      vim.cmd('hi! link SignColumn Comment')
      vim.cmd('hi! link FoldColumn LineNr')
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    enabled = true,
    event = { 'VeryLazy' },
  },
  {
    'olimorris/onedarkpro.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      local theme = require('onedarkpro')
      local colors = require("onedarkpro.helpers").get_colors()

      theme.setup({
        options = {
          cursorline = true, -- Use cursorline highlighting?
          terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
          transparency = false, -- Use a transparent background?
        }
      })

      vim.cmd('colorscheme onedark')

      vim.cmd('hi! EndOfBuffer guifg=bg')
      vim.cmd('hi! SignColumn guibg=bg')
      vim.cmd('hi! WinSeparator guifg=bg')
      vim.cmd('hi! WinSeparator guifg=bg')

      vim.cmd('hi! link CursorLineNr Comment')
      vim.cmd('hi! link FoldColumn LineNr')
      vim.cmd('hi! link SignColumn Comment')
      vim.cmd('hi! link SignColumn Comment')

      vim.cmd('hi! link NeoTreeDirectoryIcon Comment')
    end
  },
}
