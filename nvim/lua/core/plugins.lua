local is_init, packer = require('plugins.packer').setup()

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
    module = 'lspconfig'
  })

  use({
    'williamboman/mason.nvim',
    module = 'mason'
  })

  use({
    'williamboman/mason-lspconfig.nvim',
    module = 'mason-lspconfig'
  })

  -- completion
  use({
    'L3MON4D3/LuaSnip',
    module = 'luasnip'
  })

  use({
    'hrsh7th/cmp-nvim-lsp',
    module = 'cmp_nvim_lsp'
  })

  use({ after = 'nvim-cmp', 'hrsh7th/cmp-buffer' })
  use({ after = 'nvim-cmp', 'hrsh7th/cmp-path' })
  use({ after = 'nvim-cmp', 'saadparwaiz1/cmp_luasnip' })

  use({
    'hrsh7th/nvim-cmp',
    event = { 'User Defer' },
    config = require('plugins.completion').setup
  })

  if (is_init) then
    packer.sync()
  end
end)
