local utils = require('core.utils')
local ready = utils.get_packer()

return require('packer').startup(function(use)
  use({
    'wbthomason/packer.nvim'
  })

  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  })

  use({
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  use({
    'ishan9299/nvim-solarized-lua',
    config = function()
      vim.cmd('colorscheme solarized-flat')
    end
  })

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        extensions = { 'fugitive' },
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {},
          lualine_b = { 'branch' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        winbar = {
          lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 2 } },
        },
        inactive_winbar = {
          lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 2 } },
        }
      })
    end
  })

  use({
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      local on_attach = function(client, bufnr)
        -- NOTE: unsure about buffer optionn
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      end

      require('lspconfig')['sumneko_lua'].setup({
        flags = { debounce_text_changes = 150 },
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true)
            }
          }
        }
      })

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end
  })

  use({
    'tpope/vim-fugitive',
  })

  if ready then
    require('packer').sync()
  end
end)
