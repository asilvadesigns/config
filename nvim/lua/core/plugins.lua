local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('plugins.escape').setup()

local plugins = {
  'kevinhwang91/promise-async',
  'nvim-tree/nvim-web-devicons',
  'wbthomason/packer.nvim',

  -- better filetyp
  { 'nathom/filetype.nvim', config = require('plugins.filetype').setup },

  -- lua utility
  { 'nvim-lua/plenary.nvim' },

  -- session manager
  { 'rmagatti/auto-session', config = require('plugins.session').setup },

  -- colorscheme
  { 'navarasu/onedark.nvim', config = require('plugins.onedark').setup },

  -- language server
  { 'neovim/nvim-lspconfig' },

  -- language server package manager
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  -- autopairs
  {
    'windwp/nvim-autopairs',
    config = require('plugins.autopairs').setup,
  },

  {
    'max397574/better-escape.nvim',
    config = require('plugins.better_escape').setup,
  },

  -- comments
  {
    'numToStr/Comment.nvim',
    config = require('plugins.comment').setup,
  },

  -- completion engine
  {
    'hrsh7th/nvim-cmp',
    config = require('plugins.completion').setup,
  },

  -- completion icons
  { 'onsails/lspkind.nvim' },

  -- completion snippets
  { 'L3MON4D3/LuaSnip' },

  -- completion sources
  { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
  { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
  { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },

  -- completion views
  -- {
  --   'glepnir/lspsaga.nvim',
  --   config = require('plugins.lspsaga').setup,
  -- },

  -- diagnostic views
  {
    'folke/trouble.nvim',
    config = require('plugins.trouble').setup,
  },

  -- colorizer
  {
    'NvChad/nvim-colorizer.lua',
    config = require('plugins.colorizer').setup,
  },

  -- file tree
  {
    'nvim-tree/nvim-tree.lua',
    config = require('plugins.tree').setup,
  },

  -- formatter
  {
    'sbdchd/neoformat',
    config = require('plugins.neoformat').setup,
  },

  -- fuzzy
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    config = require('plugins.telescope').setup,
  },

  -- git
  {
    'tpope/vim-fugitive',
  },

  -- git signs
  {
    'lewis6991/gitsigns.nvim',
    config = require('plugins.gitsigns').setup,
  },

  -- -- indentline
  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = require('plugins.indent').setup,
  -- },

  -- leap
  {
    'ggandor/leap.nvim',
    config = require('plugins.leap').setup,
  },

  -- matchup
  {
    'andymass/vim-matchup',
  },

  -- -- scrolling
  -- {
  --   'karb94/neoscroll.nvim',
  --   config = require('plugins.neoscroll').setup,
  -- },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    config = require('plugins.lualine').setup,
  },

  -- surround
  {
    'kylechui/nvim-surround',
    config = require('plugins.surround').setup,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = require('plugins.treesitter').setup,
  },

  -- treesitter autotags
  {
    'https://github.com/windwp/nvim-ts-autotag',
    config = require('plugins.treesitter_autotag').setup,
  }
}

require('lazy').setup(plugins)
