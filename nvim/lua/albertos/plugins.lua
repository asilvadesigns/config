return require('packer').startup(function(use)
  -- packer manage self
  use('wbthomason/packer.nvim')
  -- lua utils
  use('nvim-lua/plenary.nvim')
  --
  -- COMPLETION
  -- lsp
  use('neovim/nvim-lspconfig')
  -- manage lsps, linters, and formatters
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  -- diagnostics
  use('folke/trouble.nvim')
  -- completion
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-path')
  use('hrsh7th/nvim-cmp')
  -- snippets
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  --
  -- EDITING
  -- autopairs
  use('windwp/nvim-autopairs')
  -- better escape
  use('max397574/better-escape.nvim')
  -- matching brackets
  use('andymass/vim-matchup')
  -- surround
  use({ 'kylechui/nvim-surround', tag = "*" })
  -- treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('windwp/nvim-ts-autotag')
  --
  -- UI
  -- colorscheme
  use('ishan9299/nvim-solarized-lua')
  use('navarasu/onedark.nvim')
  -- file explorer
  use('kyazdani42/nvim-tree.lua')                                   -- file tree
  -- fuzzy finder
  use('nvim-telescope/telescope.nvim')
  -- icons
  use('kyazdani42/nvim-web-devicons')
  use('onsails/lspkind.nvim')
  -- project management
  use('ahmedkhalf/project.nvim')
  -- statusline
  use('nvim-lualine/lualine.nvim')
end)
