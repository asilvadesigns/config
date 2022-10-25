local utils = require('core.utils')

local packer = utils.get_packer()
local state = utils.get_state()

packer.init()

packer.use('nathom/filetype.nvim')
packer.use('nvim-lua/plenary.nvim')
packer.use('wbthomason/packer.nvim')

packer.use({
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup({ log_level = 'error' })
  end
})

packer.use({
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup({ style = 'dark' })
    require('onedark').load()
  end
})

packer.use({
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('plugins.statusline')
  end
})

packer.use({
  'kyazdani42/nvim-tree.lua',
  event = { 'User PackerComplete', 'User Priority1' },
  config = function()
    require('plugins.tree')
  end
})

packer.use({
  'tpope/vim-fugitive',
  event = { 'User PackerComplete', 'User Priority2' },
})

packer.use({
  'folke/trouble.nvim',
  event = { 'User PackerComplete', 'User Priority2' },
  config = function()
    require('trouble').setup()
  end
})

--
-- Completion
packer.use({
  'hrsh7th/nvim-cmp',
  event = { 'User PackerComplete', 'User Priority3' },
  wants = { 'LuaSnip' },
  requires = { 'L3MON4D3/LuaSnip', 'neovim/nvim-lspconfig' },
  config = function()
    require('plugins.completion')
  end,
})

packer.use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
packer.use({ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' })
packer.use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
packer.use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })

--
-- Navigation
packer.use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  },
  event = { 'User PackerComplete', 'User Priority3' },
  config = function()
    require('plugins.telescope')
  end
})

--
-- Editing
packer.use({
  'max397574/better-escape.nvim',
  event = { 'User PackerComplete', 'User Priority4' },
  config = function()
    require("better_escape").setup({ mapping = { "kj" }, })
  end
})

packer.use({
  'windwp/nvim-autopairs',
  event = { 'User PackerComplete', 'User Priority4' },
  config = function()
    require('nvim-autopairs').setup()
  end
})

packer.use({
  'kylechui/nvim-surround',
  event = { 'User PackerComplete', 'User Priority4' },
  config = function()
    require('nvim-surround').setup()
  end
})

packer.use({
  'andymass/vim-matchup',
  event = { 'User PackerComplete', 'User Priority4' },
})

packer.use({
  'numToStr/Comment.nvim',
  event = { 'User PackerComplete', 'User Priority4' },
  config = function()
    require('Comment').setup()
  end
})


if (state.should_sync) then
  utils.reload()
end

--use({
--  'ishan9299/nvim-solarized-lua',
--  config = function()
--    -- NOTE: disabled for now
--    -- vim.cmd('colorscheme solarized-flat')
--  end
--})
--})
