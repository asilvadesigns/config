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

-- packer.use({
--   'j-hui/fidget.nvim',
--   config = function()
--     require('fidget').setup()
--   end
-- })

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
  'max397574/better-escape.nvim',
  event = { 'User PackerComplete', 'User Priority1' },
  config = function()
    require("better_escape").setup({ mapping = { "kj" }, })
  end
})

packer.use({
  'windwp/nvim-autopairs',
  event = { 'User PackerComplete', 'User Priority1' },
  config = function()
    require('nvim-autopairs').setup()
  end
})

packer.use({
  'kylechui/nvim-surround',
  event = { 'User PackerComplete', 'User Priority1' },
  config = function()
    require('nvim-surround').setup()
  end
})

packer.use({
  'andymass/vim-matchup',
  event = { 'User PackerComplete', 'User Priority1' },
})

packer.use({
  'tpope/vim-fugitive',
  event = { 'User PackerComplete', 'User Priority1' },
})

packer.use({
  'numToStr/Comment.nvim',
  event = { 'User PackerComplete', 'User Priority2' },
  config = function()
    require('Comment').setup()
  end
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
  'neovim/nvim-lspconfig',
  event = { 'User PackerComplete', 'User Priority3' },
  config = function()
    require('plugins.completion')
  end
})

-- packer.use({ 'L3MON4D3/LuaSnip', after = 'lspconfig' })
-- packer.use({ 'onsails/lspkind', after = 'LuaSnip' })
-- packer.use({ 'hrsh7th/nvim-cmp', after = 'neovim/nvim-lspconfig' })
-- packer.use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })
-- packer.use({ 'hrsh7th/cmp-nvim-lsp' , after = "cmp_luasnip", })

--
-- Navigation
packer.use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  },
  event = { 'User PackerComplete', 'User Priority4' },
  config = function()
    require('plugins.telescope')
  end
})

packer.use({
  'kyazdani42/nvim-tree.lua',
  event = { 'User PackerComplete', 'User Priority4' },
  config = function()
    require('nvim-tree').setup({
      respect_buf_cwd = true,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        ignore_list = {},
        update_cwd = true,
      },
      git = {
        enable = false,
        ignore = false
      },
      view = { width = 40 },
    })

    vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
    vim.keymap.set('n', '<LEADER>j', '<CMD>NvimTreeFindFile<CR>')
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
