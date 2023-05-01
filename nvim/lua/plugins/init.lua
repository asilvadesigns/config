return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      'L3MON4D3/LuaSnip',
      -- "f3fora/cmp-spell",
      -- "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-calc",
      -- "hrsh7th/cmp-cmdline",
      -- "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'path' },
        },
      })
    end
  },
  {
    'alexghergh/nvim-tmux-navigation',
    event = { 'VeryLazy' },
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown, opts)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, opts)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, opts)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive, opts)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext, opts)
    end,
  },
  {
    "folke/persistence.nvim",
    event = { 'VeryLazy' },
    module = "persistence",
    config = function()
      require("persistence").setup()

      local session_load = function()
        require("persistence").load()
      end

      vim.api.nvim_create_user_command("SessionLoad", session_load, {})
      vim.keymap.set('n', '<leader>sl', session_load, { noremap = true, desc = '[s]ession [l]oad'})

      -- vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
      --   callback = function()
      --     session_load()
      --   end,
      -- })
    end,
  },
  {
    "folke/which-key.nvim",
    event = { 'VeryLazy' },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
  -- {
  --   'j-hui/fidget.nvim',
  --   dependencies = {
  --     'neovim/nvim-lspconfig',
  --   },
  --   config = function()
  --     require('fidget').setup()
  --   end,
  -- },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local lsp_on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- TODO: add when I get cmp setup
      -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local lsp_servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        tsserver = {},
      }

      require('neodev').setup()

      require('mason').setup()

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(lsp_servers)
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = lsp_capabilities,
            on_attach = lsp_on_attach,
            settings = lsp_servers[server_name]
          })
        end
      })
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.opt.list = true
      -- vim.opt.listchars:append('eol:↴')

      require('indent_blankline').setup({
        show_end_of_line = false,
      })

      vim.cmd('let g:indent_blankline_enabled = v:false')
      vim.cmd('hi! link IndentBlanklineChar Comment')
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
  
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'css',
          'html',
          'javascript',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'scss',
          'tsx',
          'typescript',
          'vim'
        },
        highlight = {
          enable = true,
        },
        -- JoosepAlviste/nvim-ts-context-commentstring
        context_commentstring = {
          enable = true,
        },
        -- andymass/vim-matchup
        matchup = {
          enable = true,
        },
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  -- NOTE: this isnt very useful atm
  -- {
  --   'nvim-treesitter/playground',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter-context',
  --   },
  --   config = function()
  --     require('treesitter-context').setup({
  --       max_lines = 1
  --     })
  --   end,
  -- },
  {
    'folke/noice.nvim',
    event = { 'VeryLazy' },
    config = function() 
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    }
  },
  {
    'andymass/vim-matchup',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  {
    'tpope/vim-fugitive',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    'ggandor/leap.nvim',
    event = { 'VeryLazy' },
    config = function()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      vim.api.nvim_set_hl(0, 'LeapMatch', {
        fg = 'white', -- set to black for light themes
        bold = true,
        nocombine = true,
      })

      -- require('leap').add_default_mappings()
      -- require('leap').setup()
      require('leap').opts.highlight_unlabeled_phase_one_targets = true

      vim.keymap.set('n', ';', "<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>")
    end,
  },
  {
    'max397574/better-escape.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('better_escape').setup({
        clear_empty_lines = false,   -- clear line after escaping if there is only whitespace
        keys = '<Esc>',              -- keys used for escaping, if it is a function will use the result everytime
        mapping = { 'kj' },          -- a table with mappings to use
        timeout = vim.o.timeoutlen,  -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      })
    end,
  },
  -- {
  --   'olimorris/onedarkpro.nvim',
  --   priority = 1000,
  --   config = function()
  --     local theme = require('onedarkpro')
  --     theme.setup()
  --     vim.cmd('colorscheme onedark')
  --   end
  -- },
  -- {
  --   'olimorris/persisted.nvim',
  --   config = function()
  --     require('persisted').setup({
  --       autoload = true,
  --     })
  --   end,
  -- },
  -- {
  --   "glepnir/lspsaga.nvim",
  --   event = { "LspAttach" },
  --   config = function()
  --     require("lspsaga").setup({
  --       symbol_in_winbar = {
  --         enable = true,
  --         separator = "  ",
  --         hide_keyword = true,
  --         show_file = false,
  --         folder_level = 2,
  --         respect_root = false,
  --         color_mode = false,
  --       }
  --     })
  --   end,
  --   dependencies = {
  --     {"nvim-tree/nvim-web-devicons"},
  --     {"nvim-treesitter/nvim-treesitter"}
  --   }
  -- }
}

