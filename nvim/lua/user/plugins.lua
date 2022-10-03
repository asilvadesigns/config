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
  use({
    'wbthomason/packer.nvim'
  })

  -- use({
  --   'lewis6991/impatient.nvim'
  -- })

  use({
    'kyazdani42/nvim-web-devicons'
  })

  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  })

  use({
    "nathom/filetype.nvim"
  })

  use({
    'nvim-lua/plenary.nvim',
    module = 'plenary'
  })

  use({
    'andymass/vim-matchup'
  })

  use({
    'navarasu/onedark.nvim',
    config = function() 
      require('onedark').setup({ style = 'dark' })
      require('onedark').load()
    end
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  })


  use({
    'windwp/nvim-ts-autotag',
    config = function() 
      require('nvim-ts-autotag').setup()
    end
  })

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        winbar = {
          lualine_a = { },
          lualine_b = { { 'filetype', icon_only = true }, 'filename' },
          lualine_c = { },
          lualine_x = {'encoding', 'fileformat' },
          lualine_y = {'progress'},
          lualine_z = { }
        },
        inactive_winbar = {
          lualine_a = { },
          lualine_b = { },
          lualine_c = { { 'filetype', icon_only = true }, 'filename' },
          lualine_x = {'encoding', 'fileformat' },
          lualine_y = {'progress'},
          lualine_z = { }
        },
        sections = {
          lualine_a = { },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {'%F'},
          lualine_x = { },
          lualine_y = { },
          lualine_z = { }
        },
      })
    end
  })

  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        git = {
          enable = true,
          ignore = false
        },
        respect_buf_cwd = true,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          ignore_list = {},
          update_cwd = true,
        },
        view = { width = 40 },
      })
    end
  })

  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

