local is_init, packer = require('plugins.packer').setup()

packer.on_complete = require('plugins.packer').handle_complete

packer.startup(function(use)
  use('nathom/filetype.nvim')
  use('wbthomason/packer.nvim')

  -- utility
  use({
    'nvim-lua/plenary.nvim',
    module = 'plenary'
  })

  -- session
  use({
    'rmagatti/auto-session',
    config = require('plugins.auto-session').setup
  })

  -- colorscheme
  use({
    'navarasu/onedark.nvim',
    config = require('plugins.onedark').setup
  })

  -- language server
  use({
    'neovim/nvim-lspconfig',
    config = require('plugins.lspconfig').setup,
  })

  -- completion
  use({
    'L3MON4D3/LuaSnip',
    module = 'luasnip'
  })

  use({
    'hrsh7th/nvim-cmp',
    event = { 'User Defer' },
    config = require('plugins.completion').setup
  })

  use({ after = 'nvim-cmp', 'hrsh7th/cmp-buffer' })
  use({ after = 'nvim-cmp', 'hrsh7th/cmp-path' })
  use({ after = 'nvim-cmp', 'saadparwaiz1/cmp_luasnip' })

  if (is_init) then
    packer.sync()
  end
end)
