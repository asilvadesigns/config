local is_init, packer = require('plugins.packer').setup()

require('plugins.escape').setup()

packer.startup(function(use)
  use('kevinhwang91/promise-async')
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
    config = require('plugins.autopairs').setup,
  })

  use({
    'max397574/better-escape.nvim',
    event = { 'User Defer' },
    config = require('plugins.better_escape').setup,
  })

  -- comments
  use({
    'numToStr/Comment.nvim',
    event = { 'User Defer' },
    config = require('plugins.comment').setup,
  })

  -- completion engine
  use({
    'hrsh7th/nvim-cmp',
    event = { 'User Defer' },
    config = require('plugins.completion').setup,
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

  -- completion views
  use({
    'glepnir/lspsaga.nvim',
    event = { 'User Defer' },
    config = require('plugins.lspsaga').setup,
  })

  -- diagnostic views
  use({
    'folke/trouble.nvim',
    event = { 'User Defer' },
    config = require('plugins.trouble').setup,
  })

  -- colorizer
  use({
    'NvChad/nvim-colorizer.lua',
    event = { 'User Defer' },
    config = require('plugins.colorizer').setup,
  })

  -- file tree
  use({
    'nvim-tree/nvim-tree.lua',
    event = { 'User Defer' },
    config = require('plugins.tree').setup,
  })

  -- formatter
  use({
    'sbdchd/neoformat',
    event = { 'User Defer' },
    config = require('plugins.neoformat').setup,
  })

  -- fuzzy
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    event = { 'User Defer' },
    config = require('plugins.telescope').setup,
  })

  -- git
  use({
    'tpope/vim-fugitive',
    event = { 'User Defer' },
  })

  -- git signs
  use({
    'lewis6991/gitsigns.nvim',
    event = { 'User Defer' },
    config = require('plugins.gitsigns').setup,
  })

  -- indentline
  use({
    'lukas-reineke/indent-blankline.nvim',
    event = { 'User Defer' },
    config = require('plugins.indent').setup,
  })

  -- leap
  use({
    'ggandor/leap.nvim',
    event = { 'User Defer' },
    config = require('plugins.leap').setup,
  })

  -- matchup
  use({
    'andymass/vim-matchup',
    event = { 'User Defer' },
  })

  -- scrolling
  use({
    'karb94/neoscroll.nvim',
    event = { 'User Defer' },
    config = require('plugins.neoscroll').setup,
  })

  -- statusline
  use({
    'nvim-lualine/lualine.nvim',
    event = { 'User Defer' },
    config = require('plugins.lualine').setup,
  })

  -- surround
  use({
    'kylechui/nvim-surround',
    event = { 'User Defer' },
    config = require('plugins.surround').setup,
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = { 'User Defer' },
    config = require('plugins.treesitter').setup,
  })

  if is_init then
    packer.sync()
  end
end)

-- NOTE: attempted to use these plugins

-- -- completion linters and formatters
-- use({
--   "jose-elias-alvarez/null-ls.nvim",
--   event = { 'User Defer' },
--   config = require('plugins.null').setup
-- })

-- -- git
-- use({
--   'TimUntersberger/neogit',
--   event = { 'User Defer' },
--   config = require('plugins.neogit').setup
-- })

-- -- folds
-- use({
--   'kevinhwang91/nvim-ufo',
--   module = 'ufo',
--   config = require('plugins.ufo').setup,
-- })

-- tree
-- use('MunifTanjim/nui.nvim')
-- use({
--   'nvim-neo-tree/neo-tree.nvim',
--   event = { 'User Defer' },
--   config = require('plugins.neotree').setup
-- })
