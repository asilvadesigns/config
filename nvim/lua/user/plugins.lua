local cmd = vim.cmd
local fn = vim.fn

-- auto install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	print("Installing packer close and reopen Neovim...")
end

-- reload plugins file on save
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- no error on first use
local ok, packer = pcall(require, "packer")
if not ok then return end

return packer.startup(function(use)
  use('wbthomason/packer.nvim') -- Have packer manage itself
  use('nvim-lua/plenary.nvim') -- Useful lua functions used by lots of plugins

  use('lewis6991/impatient.nvim') -- cache plugins

  use('ggandor/leap.nvim') -- jump
  use('kyazdani42/nvim-tree.lua') -- file tree
  use('nvim-telescope/telescope.nvim') -- fuzzy finder
  use('nvim-pack/nvim-spectre') -- search & replace

  use('ishan9299/nvim-solarized-lua') -- solarized
  use('kyazdani42/nvim-web-devicons') -- icons
  use('lewis6991/gitsigns.nvim') -- git signs
  use('navarasu/onedark.nvim') -- onedark

  use('j-hui/fidget.nvim') -- lsp progress
  use('neovim/nvim-lspconfig') -- lsp config
  use('williamboman/mason-lspconfig.nvim') -- lsp mason config
  use('williamboman/mason.nvim') -- lsp package manager

  use('L3MON4D3/LuaSnip')
  use('glepnir/lspsaga.nvim')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-path')
  use('hrsh7th/nvim-cmp')
  use('onsails/lspkind-nvim')

  use('andymass/vim-matchup') -- matching brackets
  use('windwp/nvim-autopairs') -- create auto pairs
  use('windwp/nvim-ts-autotag') -- create auto tags

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate '})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
