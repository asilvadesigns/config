local ready = require('core.utils').get_packer()

return require('packer').startup(function(use)
  use({
    'wbthomason/packer.nvim'
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
    'tpope/vim-fugitive',
    config = function()
      vim.opt.statusline = '%{FugitiveStatusLine()}'
    end
  })

  if ready then
    require('packer').sync()
  end
end)
