return require('packer').startup(function(use)
	-- packer manage self
	use('wbthomason/packer.nvim')
	-- lua utils
	use('nvim-lua/plenary.nvim')
	-- fuzzy finder
	use('nvim-telescope/telescope.nvim')
  -- colorscheme
  use('ishan9299/nvim-solarized-lua')
end)
