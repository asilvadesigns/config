local ready = require('core.utils').get_packer()

return require('packer').startup(function(use)
  use({
    'wbthomason/packer.nvim'
  })

  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  })

  use({
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  use({
    'ishan9299/nvim-solarized-lua',
    config = function()
      vim.cmd('colorscheme solarized-flat')
    end
  })

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        extensions = { 'fugitive' },
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        winbar = {
          lualine_a = {},
          lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 2 } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 2 } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        }
      })
    end
  })

  use({
    'tpope/vim-fugitive',
  })

  if ready then
    require('packer').sync()
  end
end)
