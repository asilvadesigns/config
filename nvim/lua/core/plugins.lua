local is_init, packer = require('plugins.packer').setup()

packer.on_complete = require('plugins.packer').handle_complete

packer.startup(function(use)
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
    config = require('plugins.lspconfig').setup,
  })

  use({
    'hrsh7th/nvim-cmp',
    event = { 'User Defer' },
    config = require('plugins.completion').setup
  })

  if (is_init) then
    packer.sync()
  end
end)
