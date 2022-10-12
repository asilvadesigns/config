local utils = require('core.utils')
local ready = utils.get_packer()

return require('packer').startup(function(use)
  use({
    'wbthomason/packer.nvim'
  })

  use({
    'nvim-lua/plenary.nvim'
  })

  use({
    'max397574/better-escape.nvim',
    config = function()
      require("better_escape").setup({
        mapping = { "kj" },
      })
    end
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
        tabline = {},
        winbar = {
          lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 3 } },
        },
        inactive_winbar = {
          lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 3 } },
        }
      })
    end
  })

  use({
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup({
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          layout_config = {
            center = { height = 0.5, width = 0.8 }
          },
          layout_strategy = 'center',
          mappings = { i = { ["<C-u>"] = false }, },
          sorting_strategy = "ascending",
        }
      })

      function project_files()
        local opts = {}
        local git_ok = pcall(require('telescope.builtin').git_files, opts)
        if not git_ok then require('telescope.builtin').find_files(opts) end
      end

      vim.keymap.set('n', '<LEADER>a', '<CMD>Telescope commands<CR>')
      vim.keymap.set('n', '<LEADER>b', '<CMD>Telescope buffers<CR>')
      vim.keymap.set('n', '<LEADER>c', '<CMD>Telescope colorscheme<CR>')
      vim.keymap.set('n', '<LEADER>e', '<CMD>Telescope oldfiles<CR>')
      vim.keymap.set('n', '<LEADER>f', '<CMD>lua project_files()<CR>')
      vim.keymap.set('n', '<LEADER>l', '<CMD>Telescope current_buffer_fuzzy_find<CR>')
    end
  })

  use({
    'kyazdani42/nvim-tree.lua',
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

  use({
    'neovim/nvim-lspconfig',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local lspconfig = require('lspconfig')

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })

      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      local lsp_flags = { debounce_text_changes = 150 }
      local lsp_on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<leader>m', vim.lsp.buf.format, bufopts)
        vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>np', vim.diagnostic.goto_prev)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
      end

      -- NOTE: available servers
      -- @see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      require('lspconfig')['jsonls'].setup({
        capabilities = lsp_capabilities,
        flags = lsp_flags,
        on_attach = lsp_on_attach,
      })

      -- @see: https://github.com/sumneko/lua-language-server
      require('lspconfig')['sumneko_lua'].setup({
        capabilities = lsp_capabilities,
        flags = lsp_flags,
        on_attach = lsp_on_attach,
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

      -- @see: https://github.com/typescript-language-server/typescript-language-server
      require('lspconfig')['tsserver'].setup({
        capabilities = lsp_capabilities,
        flags = lsp_flags,
        on_attach = lsp_on_attach,
      })

      -- @see:
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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
