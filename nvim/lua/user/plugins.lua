local PACKER_BOOTSTRAP = require('core')

-- avoid errors on first use
local ok, packer = pcall(require, 'packer')
if (not ok) then return end

return packer.startup(function(use)
  -- use('lewis6991/impatient.nvim')
  use('nvim-lua/plenary.nvim')

  -- -- editing
  -- use('andymass/vim-matchup')
  -- use('kylechui/nvim-surround')
  -- use('nathom/filetype.nvim')
  -- use('numToStr/Comment.nvim')
  -- use('windwp/nvim-autopairs')

  -- -- navigation
  -- use('kyazdani42/nvim-tree.lua')
  -- use('nvim-lualine/lualine.nvim')
  -- use('nvim-telescope/telescope.nvim')

  -- -- theme
  -- use('kyazdani42/nvim-web-devicons')
  -- use('lewis6991/gitsigns.nvim')
  -- use('navarasu/onedark.nvim')
  use({
    'ishan9299/nvim-solarized-lua',
    config = function()
      vim.cmd('colorscheme solarized-flat')
    end
  })

  -- utils
  use('wbthomason/packer.nvim')

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

