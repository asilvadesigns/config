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
end)
