local is_init, packer = require('plugins.packer').setup()

return packer.startup(function(use)
  use('nathom/filetype.nvim')
  use('wbthomason/packer.nvim')

  use({
    'nvim-lua/plenary.nvim',
    module = 'plenary'
  })

  use({
    'rmagatti/auto-session',
    config = require('plugins.auto-session').setup
  })

  use({
    'navarasu/onedark.nvim',
    config = require('plugins.onedark').setup
  })

  use({
    'neovim/nvim-lspconfig',
    config = require('plugins.completion').setup,
  })

  if (is_init) then
    packer.sync()
  end
end)
