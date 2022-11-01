local utils = require('core.utils')

local packer = utils.get_packer()
local state = utils.get_state()

return packer.startup(function(use)
  use('nathom/filetype.nvim')
  use('nvim-lua/plenary.nvim')
  use('wbthomason/packer.nvim')

  use({
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup({
        log_level = 'error',
        pre_save_cmds = { 'CtrlSFClose', 'NvimTreeClose', 'TroubleClose' },
      })
    end
  })

  use({
    'nvim-tree/nvim-web-devicons',
  })

  use({
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({ style = 'dark' })
      require('onedark').load()
    end
  })

  use({
    'nvim-lualine/lualine.nvim',
    event = { 'User PackerComplete', 'User DeferLoad1' },
    config = function()
      require('plugins.statusline')
    end
  })

  -- use({
  --   'ishan9299/nvim-solarized-lua',
  --   event = { 'User PackerComplete', 'User DeferLoad1' },
  --   config = function()
  --     -- NOTE: disabled for now
  --     -- vim.cmd('colorscheme solarized-flat')
  --   end
  -- })

  -- use({
  --   'nvim-treesitter/nvim-treesitter',
  --   event = { 'User PackerComplete', 'User DeferLoad1' },
  --   run = ':TSUpdate',
  --   config = function()
  --     require('nvim-treesitter.configs').setup({
  --       ensure_installed = {
  --         'bash',
  --         'css',
  --         'gitignore',
  --         'html',
  --         'javascript',
  --         'json',
  --         'lua',
  --         'markdown',
  --         'scss',
  --         'tsx',
  --         'typescript',
  --         'yaml',
  --       },
  --       highlight = {
  --         enable = false
  --       }
  --     })
  --   end
  -- })

  --
  -- Navigation
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    event = { 'User PackerComplete', 'User DeferLoad1' },
    config = function()
      require('plugins.telescope')
    end
  })

  -- use({
  --   'j-hui/fidget.nvim',
  --   event = { 'User PackerComplete', 'User DeferLoad1' },
  --   config = function()
  --     require('fidget').setup({})
  --   end
  -- })

  use({
    'NvChad/nvim-colorizer.lua',
    event = { 'User PackerComplete', 'User DeferLoad2' },
    config = function()
      require('colorizer').setup({})
    end
  })

  use({
    'tpope/vim-fugitive',
    event = { 'User PackerComplete', 'User DeferLoad2' },
  })

  use({
    'folke/trouble.nvim',
    event = { 'User PackerComplete', 'User DeferLoad2' },
    config = function()
      require('trouble').setup({
        auto_preview = false,
      })
    end
  })

  use({
    'kyazdani42/nvim-tree.lua',
    event = { 'User PackerComplete', 'User DeferLoad3' },
    config = function()
      require('plugins.tree')
    end
  })

  --
  -- Completion
  use({
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

  use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
  use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })

  --
  -- Editing
  use({
    'max397574/better-escape.nvim',
    event = { 'User PackerComplete', 'User DeferLoad4' },
    config = function()
      require("better_escape").setup({ mapping = { "kj" }, })
    end
  })

  use({
    'windwp/nvim-autopairs',
    event = { 'User PackerComplete', 'User DeferLoad4' },
    config = function()
      require('nvim-autopairs').setup({})
    end
  })

  use({
    'kylechui/nvim-surround',
    event = { 'User PackerComplete', 'User DeferLoad4' },
    config = function()
      require('nvim-surround').setup({})
    end
  })

  use({
    'andymass/vim-matchup',
    event = { 'User PackerComplete', 'User DeferLoad4' },
  })

  use({
    'numToStr/Comment.nvim',
    event = { 'User PackerComplete', 'User DeferLoad4' },
    config = function()
      require('Comment').setup({})
    end
  })

  use({
    'ggandor/leap.nvim',
    event = { 'User PackerComplete', 'User DeferLoad4' },
    config = function()
      require('plugins.leap')
    end
  })

  use({
    'dyng/ctrlsf.vim',
    event = { 'User PackerComplete', 'User DeferLoad5' }
  })

  if (state.should_sync) then
    packer.sync()
  end
end)
