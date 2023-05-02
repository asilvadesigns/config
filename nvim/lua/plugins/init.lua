return {
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
    enabled = true,
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
        -- was <leader>ca
        nmap('<C-.>', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('<leader>m', vim.lsp.buf.format, 'For[m]at')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        --
        -- -- See `:help K` for why this keymap
        -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        --
        -- -- Lesser used LSP functionality
        -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- TODO: add when I get cmp setup
      lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(lsp_capabilities)

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
    enabled = true,
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
    'folke/noice.nvim',
    enabled = true,
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
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    }
  },
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
