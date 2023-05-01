return {
  {
    'ishan9299/nvim-solarized-lua',
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
    event = { 'BufReadPost', 'BufNewFile' },
  },
}
