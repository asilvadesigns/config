return require('packer').startup(function(use)
  -- packer manage self
  use('wbthomason/packer.nvim')
  -- lua utils
  use('nvim-lua/plenary.nvim')
  -- fuzzy finder
  use('nvim-telescope/telescope.nvim')
  -- colorscheme
  use('ishan9299/nvim-solarized-lua')
  use('navarasu/onedark.nvim')
  -- icons
  use('kyazdani42/nvim-web-devicons')
  -- manage lsps, linters, and formatters
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('neovim/nvim-lspconfig')
  -- project management
  use('ahmedkhalf/project.nvim')
  -- matching brackets
  use('andymass/vim-matchup')
  -- autopairs
  use('windwp/nvim-autopairs')
  -- better escape
  use('max397574/better-escape.nvim')
  -- diagnostics
  use('folke/trouble.nvim')
  -- treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('windwp/nvim-ts-autotag')
  -- surround
  use({ 'kylechui/nvim-surround', tag = "*" })                      -- add motions for surround functionality
end)
