local is_init, packer = require('plugins.packer').setup()

require('plugins.escape').setup()

packer.startup(function(use)
  use('nathom/filetype.nvim')
  use('nvim-tree/nvim-web-devicons')
  use('wbthomason/packer.nvim')

  -- lua utility
  use({ 'nvim-lua/plenary.nvim', module = 'plenary' })

  -- session manager
  use({ 'rmagatti/auto-session', config = require('plugins.session').setup })

  -- colorscheme
  use({ 'navarasu/onedark.nvim', config = require('plugins.onedark').setup })

  -- language server
  use({ 'neovim/nvim-lspconfig', module = 'lspconfig' })

  -- language server package manager
  use({ 'williamboman/mason.nvim', module = 'mason' })
  use({ 'williamboman/mason-lspconfig.nvim', module = 'mason-lspconfig' })

  -- autopairs
  use({
    'windwp/nvim-autopairs',
    event = { 'User Defer' },
    config = require('plugins.autopairs').setup
  })

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
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
  use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })

  -- colorizer
  use({
    'NvChad/nvim-colorizer.lua',
    event = { 'User Defer' },
    config = require('plugins.colorizer').setup
  })

  -- file tree
  use({
    'nvim-tree/nvim-tree.lua',
    event = { 'User Defer' },
    config = require('plugins.tree').setup
  })

  -- fuzzy
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    event = { 'User Defer' },
    config = require('plugins.telescope').setup
  })

  -- git
  use({
    'tpope/vim-fugitive',
    event = { 'User Defer' },
  })

  -- statusline
  use({
    'nvim-lualine/lualine.nvim',
    event = { 'User Defer' },
    config = require('plugins.lualine').setup
  })

  -- surround
  use({
    'kylechui/nvim-surround',
    event = { 'User Defer' },
    config = require('plugins.surround').setup
  })

  if (is_init) then
    packer.sync()
  end
end)

-- NOTE: attempted to use these plugins
-- use('MunifTanjim/nui.nvim')
-- use({
--   'nvim-neo-tree/neo-tree.nvim',
--   event = { 'User Defer' },
--   config = require('plugins.neotree').setup
-- })
--
-- use({
--   'TimUntersberger/neogit',
--   event = { 'User Defer' },
--   config = require('plugins.neogit').setup
-- })
