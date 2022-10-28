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
    require('auto-session').setup({
      log_level = 'error',
      pre_save_cmds = { 'CtrlSFClose', 'NvimTreeClose', 'TroubleClose' },
    })
  end
})

packer.use({
  'nvim-tree/nvim-web-devicons',
})

packer.use({
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup({ style = 'dark' })
    require('onedark').load()
  end
})

packer.use({
  'ishan9299/nvim-solarized-lua',
  event = { 'User PackerComplete', 'User DeferLoad1' },
  config = function()
    -- NOTE: disabled for now
    -- vim.cmd('colorscheme solarized-flat')
  end
})

packer.use({
  'kyazdani42/nvim-tree.lua',
  event = { 'User PackerComplete', 'User DeferLoad1' },
  config = function()
    require('plugins.tree')
  end
})

packer.use({
  'nvim-lualine/lualine.nvim',
  event = { 'User PackerComplete', 'User DeferLoad1' },
  config = function()
    require('plugins.statusline')
  end
})

packer.use({
  'j-hui/fidget.nvim',
  event = { 'User PackerComplete', 'User DeferLoad1' },
  config = function()
    require('fidget').setup({})
  end
})

packer.use({
  'NvChad/nvim-colorizer.lua',
  event = { 'User PackerComplete', 'User DeferLoad2' },
  config = function()
    require('colorizer').setup({})
  end
})

packer.use({
  'tpope/vim-fugitive',
  event = { 'User PackerComplete', 'User DeferLoad2' },
})

packer.use({
  'folke/trouble.nvim',
  event = { 'User PackerComplete', 'User DeferLoad2' },
  config = function()
    require('trouble').setup({
      auto_preview = false,
    })
  end
})

--
-- Completion
packer.use({
  'hrsh7th/nvim-cmp',
  event = { 'User PackerComplete', 'User DeferLoad3' },
  requires = {
    'L3MON4D3/LuaSnip',
    'neovim/nvim-lspconfig',
  },
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
  event = { 'User PackerComplete', 'User DeferLoad3' },
  config = function()
    require('plugins.telescope')
  end
})

--
-- Editing
packer.use({
  'max397574/better-escape.nvim',
  event = { 'User PackerComplete', 'User DeferLoad4' },
  config = function()
    require("better_escape").setup({ mapping = { "kj" }, })
  end
})

packer.use({
  'windwp/nvim-autopairs',
  event = { 'User PackerComplete', 'User DeferLoad4' },
  config = function()
    require('nvim-autopairs').setup({})
  end
})

packer.use({
  'kylechui/nvim-surround',
  event = { 'User PackerComplete', 'User DeferLoad4' },
  config = function()
    require('nvim-surround').setup({})
  end
})

packer.use({
  'andymass/vim-matchup',
  event = { 'User PackerComplete', 'User DeferLoad4' },
})

packer.use({
  'numToStr/Comment.nvim',
  event = { 'User PackerComplete', 'User DeferLoad4' },
  config = function()
    require('Comment').setup({})
  end
})

packer.use({
  'ggandor/leap.nvim',
  event = { 'User PackerComplete', 'User DeferLoad4' },
  config = function()
    require('plugins.leap')
  end
})

packer.use({
  'kazhala/close-buffers.nvim',
  event = { 'User PackerComplete', 'User DeferLoad4' },
  config = function()
    require('close_buffers').setup({
      filetype_ignore = { 'NvimTree' }
    })

    vim.keymap.set(
      'n',
      '<C-w>o',
      "<CMD>lua require('close_buffers').delete({ type = 'other' })<CR>",
      { noremap = true, silent = true }
    )
  end
})

packer.use({
  'nvim-pack/nvim-spectre',
  event = { 'User PackerComplete', 'User DeferLoad5' },
  config = function()
    require('spectre').setup({})
  end
})

packer.use({
  'dyng/ctrlsf.vim',
  event = { 'User PackerComplete', 'User DeferLoad5' }
})

if (state.should_sync) then
  utils.reload()
end
