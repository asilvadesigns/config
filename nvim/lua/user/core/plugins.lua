local is_init, packer = require('user.plugins').setup()

packer.startup(function(use)
  use('nathom/filetype.nvim')
  use('nvim-lua/plenary.nvim')
  use('wbthomason/packer.nvim')

  use({
    'rmagatti/auto-session',
    config = function()
      require('user.plugins.auto-session').setup()
    end
  })

  use({
    'navarasu/onedark.nvim',
    config = function()
      require('user.plugins.onedark').setup()
    end
  })

  if (is_init) then
    packer.sync()
  end
end)
