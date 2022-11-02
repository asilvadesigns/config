local is_init, packer = require('plugins.packer').setup()

packer.startup(function(use)
  use('nathom/filetype.nvim')
  use('wbthomason/packer.nvim')

  -- utility
  use({ 'nvim-lua/plenary.nvim', module = 'plenary' })

  -- session
  use({ 'rmagatti/auto-session', config = require('plugins.session').setup })

  -- colorscheme
  use({ 'navarasu/onedark.nvim', config = require('plugins.onedark').setup })

  -- language server
  use({ 'neovim/nvim-lspconfig', module = 'lspconfig' })

  -- language server package manager
  use({ 'williamboman/mason.nvim', module = 'mason' })
  use({ 'williamboman/mason-lspconfig.nvim', module = 'mason-lspconfig' })

  -- completion engine
  use({
    'hrsh7th/nvim-cmp',
    event = { 'User Defer' },
    config = require('plugins.completion').setup
  })

  -- completion icons
  use({ 'onsails/lspkind.nvim', module = 'lspkind' })

  -- completion snippets
  use({ 'L3MON4D3/LuaSnip', module = 'luasnip' })

  -- completion sources
  use({ 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' })
  use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp'  })
  use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'  })

  if (is_init) then
    packer.sync()
  end
end)
