local fn = vim.fn

-- auto install packer
local install_path = fn.stdpath('data').. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd [[packadd packer.nvim]]
end

-- reload neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- avoid errors on first use
local ok, packer = pcall(require, 'packer')
if (not ok) then return end

return packer.startup(function(use)
  -- use({
  --   'lewis6991/impatient.nvim'
  -- })
  use('wbthomason/packer.nvim')

  use('nathom/filetype.nvim')
  use('nvim-lua/plenary.nvim')

  use('andymass/vim-matchup')
  use('windwp/nvim-autopairs')

  use('kyazdani42/nvim-web-devicons')
  use('lewis6991/gitsigns.nvim')
  use('navarasu/onedark.nvim')

  -- use('kyazdani42/nvim-tree.lua')
  use('nvim-lualine/lualine.nvim')
  use('nvim-telescope/telescope.nvim')

  -- use({
  --   'nvim-treesitter/nvim-treesitter',
  --   run = function()
  --     require('nvim-treesitter.install').update({ with_sync = true })
  --   end,
  -- })

  -- use({
  --   'windwp/nvim-ts-autotag',
  --   config = function() 
  --     require('nvim-ts-autotag').setup()
  --   end
  -- })

  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

