return {
  {
    "folke/flash.nvim",
    enabled = true,
    event = { 'VeryLazy' },
    opts = { },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      { "<c-;>", mode = { "n" }, function() require("flash").jump() end, desc = "Toggle Flash Jump" }
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    enabled = true,
    event = { 'VeryLazy' },
  },
  {
    'folke/edgy.nvim',
    enabled = false,
    event = { 'VeryLazy' },
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      animate = {
        enabled = false,
      },
      bottom = {
        { title = 'Trouble', ft = 'Trouble' },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },
      left = {
        { title = 'Neotree', ft = 'neo-tree' },
      },
    },
  },
  {
    'max397574/better-escape.nvim',
    enabled = true,
    event = { 'InsertEnter' },
    config = function()
      require('better_escape').setup({
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = '<Esc>', -- keys used for escaping, if it is a function will use the result everytime
        mapping = { 'kj' }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      })
    end,
  },
  {
    'kylechui/nvim-surround',
    enabled = true,
    event = { 'CursorMoved' },
    keys = {
      {
        'ds',
        'cs',
      }
    },
    opts = {},
  },
  {
    "gbprod/substitute.nvim",
    enabled = true,
    event = { 'CursorMoved' },
    opts = {},
    config = function()
      vim.keymap.set("x", "X", require('substitute.exchange').visual, { noremap = true })
    end
  },
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    enabled = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      delete_to_trash = false,
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    enabled = true,
    config = function()
      require('mason').setup({
        ensure_installed = {
          'angularls',
          'cssls',
          'lua_ls',
          'tsserver',
        }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'folke/neodev.nvim' },
    opts = {
      servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        angularls = {},
        cssls = {},
        tsserver = {},
      }
    },
    config = function(_, opts)
      -- Diagnostic config
      vim.diagnostic.config({
        underline = true,
        virtual_text = false,
      })

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

      -- Diagnostics in gutter
      -- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
      local icons = require('config.options').icons

      local signs = {
        Error = icons.error,
        Hint = icons.hint,
        Info = icons.info,
        Warn = icons.warn,
      }

      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, {
          linehl = "",
          numhl = "",
          text = icon,
          texthl = hl,
        })
      end

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

        local vmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        -- was <leader>ca
        nmap('<c-.>', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('<leader>m', vim.lsp.buf.format, 'For[m]at')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        --
        -- -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        vmap('i', '<c-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
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

      require('neodev').setup()

      for server, server_opts in pairs(opts.servers) do
        require('lspconfig')[server].setup({
          capabilities = lsp_capabilities,
          on_attach = lsp_on_attach,
          settings = server_opts,
        })
      end
      -- local lsp_server_settings = {
      --   lua_ls = {
      --     Lua = {
      --       workspace = { checkThirdParty = false },
      --       telemetry = { enable = false },
      --     },
      --   },
      --   angularls = {
      --     single_file_support = false,
      --     root_dir = lsp_config.util.find_git_ancestor(filename)
      --   },
      --   tsserver = {
      --     single_file_support = false,
      --     -- root_dir = function(filename, bufnr)
      --     --   return lsp_config.util.find_git_ancestor(filename)
      --     -- end
      --   },
      -- }
      -- require('mason').setup()
      -- require('mason-lspconfig').setup({
      --   ensure_installed = vim.tbl_keys(lsp_server_settings)
      -- })
      -- require('mason-lspconfig').setup_handlers({
      --   function(server_name)
      --     require('lspconfig')[server_name].setup({
      --       capabilities = lsp_capabilities,
      --       on_attach = lsp_on_attach,
      --       settings = lsp_server_settings[server_name]
      --     })
      --   end
      -- })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    event = "InsertEnter",
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
    'kevinhwang91/nvim-ufo',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end },
      { 'zM', function() require('ufo').closeAllFolds() end },
    },
    dependencies = {
      'kevinhwang91/promise-async',
      'luukvbaal/statuscol.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    -- opts = {
    --   open_fold_hl_timeout = 0,
    --   fold_virt_text_handler = function(text, lnum, endLnum, width)
    --     local suffix = "  "
    --     local lines  = ('[%d lines] '):format(endLnum - lnum)
    --
    --     local cur_width = 0
    --     for _, section in ipairs(text) do
    --       cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
    --     end
    --
    --     suffix = suffix .. (' '):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)
    --
    --     table.insert(text, { suffix, 'Comment' })
    --     table.insert(text, { lines, 'Todo' })
    --     return text
    --   end,
    --   preview = {
    --     win_config = {
    --       border       = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    --       winblend     = 0,
    --       winhighlight = "Normal:LazyNormal",
    --     }
    --   },
    -- },
    config = function()
      require('ufo').setup({
        open_fold_hl_timeout = 0,
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })

      -- TODO: move to config.icons
      --      

      -- NOTE: small icons
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      -- NOTE: large icons
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      require('statuscol').setup({
        relculright = true,
        segments = {
          { text = { '%s' }, click = 'v:lua.ScSa' },
          { text = { require('statuscol.builtin').lnumfunc, ' ' }, click = 'v:lua.ScLa' },
          { text = { require('statuscol.builtin').foldfunc, ' ' }, click = 'v:lua.ScFa' },
        },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
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
    'nvim-treesitter/nvim-treesitter-context',
    event = { "BufReadPost" },
    cmds = { "TSContextToggle" },
    keys = {
      {
        "<leader>uC", "<cmd>TSContextToggle<cr>",
        desc = "Toggle TS Context"
      },
      {
        "gC",
        function()
          require("treesitter-context").go_to_context()
        end,
        desc = "Go to treesitter context",
      },
    },
    opts = {
      mode = "topline",
      enable = false
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    event = { "VeryLazy" },
    keys = {
      {
        "<leader>s",
        "<cmd>SymbolsOutline<cr>",
        desc = "Symbols outline",
      },
    },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    branch = "v2.x",
    keys = {
      {
        '<leader>j',
        '<CMD>NeoTreeReveal<CR>',
        desc = 'reveal file in explorer'
      },
      {
        '<leader>x',
        -- '<CMD>Neotree position=current reveal_path=%:p:h reveal_file=%:p<CR>',
        '<CMD>Neotree position=current reveal_file=%:p<CR>',
        desc = 'reveal file in current buffer'
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require('neo-tree').setup({
        enable_diagnostics = true,
        enable_git_status = false,
        enable_modified_markers = false,
        buffers = {
          follow_current_file = false,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = false,
          renderers = {
            file = {
              { "indent" },
              { "name" },
            }
          }
        },
        default_component_configs = {
          indent = {
            indent_marker = "│",
            indent_size = 2,
            last_indent_marker = "└",
            with_markers = true,
          },
          icon = {
            -- NOTE: large icons
            -- folder_closed = '',
            -- folder_open = '',
            -- NOTE: small icons
            folder_closed = '',
            folder_open = '',
          }
        },
        use_default_mappings = false,
        window = {
          mappings = {
            -- operations
            ["<cr>"] = "open",
            ["<space>"] = "toggle_node",
            ["A"] = "add_directory",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
            -- movements
            ["<bs>"] = "navigate_up",
            -- searching
            ["#"] = "fuzzy_sorter",
            ["<c-x>"] = "clear_filter",
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            -- splits
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- toggle
            ["H"] = "toggle_hidden",
            ["R"] = "refresh",
          }
        }
      })
    end
  },
  {
    'dstein64/nvim-scrollview',
    enabled = false,
    event = { 'VeryLazy' },
    config = function()
      require('scrollview').setup({
        excluded_filetypes = { 'NvimTree' },
        current_only = false,
        winblend = 75,
        base = 'buffer',
        column = 80,
      })
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    enabled = true,
    build = 'make',
    event = { 'VeryLazy' },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = true,
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
      ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'gitignore',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'prisma',
        'python',
        'scss',
        'tsx',
        'typescript',
        'vim',
        'yaml',
      },
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    enabled = true,
    event = { 'VeryLazy' },
    opts = {}
  },
  {
    'numToStr/Comment.nvim',
    enabled = true,
    event = { 'VeryLazy' },
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
    'folke/trouble.nvim',
    enabled = true,
    cmd = { 'ToggleTrouble', 'Trouble' },
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      fold_closed = "", -- icon used for closed folds
      fold_open = "", -- icon used for open folds
      use_diagnostic_signs = true
    }
  },
  {
    'alexghergh/nvim-tmux-navigation',
    enabled = false,
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
    'ishan9299/nvim-solarized-lua',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme solarized-flat')
      vim.cmd('hi EndOfBuffer guifg=bg')
      vim.cmd('hi WinSeparator guifg=bg')

      vim.cmd('hi! link SignColumn Comment')
      vim.cmd('hi! link FoldColumn LineNr')
    end
  },
  {
    'olimorris/onedarkpro.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      local theme = require('onedarkpro')
      -- local colors = require("onedarkpro.helpers").get_colors()

      theme.setup({
        options = {
          cursorline = true,
          terminal_colors = true,
          transparency = false,
        },
        highlights = {
          --
          CursorLineNr = { link = "Comment" },
          EndOfBuffer = { fg = 'bg' },
          FoldColumn = { link = "LineNr" },
          SignColumn = { link = "Comment" },
          WinSeparator = { fg = 'bg' },
          --
          NeoTreeDirectoryIcon = { link = "Comment" },
        }
      })

      vim.cmd("colorscheme onedark")
    end
  },
  {
    'windwp/nvim-autopairs',
    enabled = true,
    event = { 'InsertEnter' },
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },
  {
    'folke/zen-mode.nvim',
    enabled = false,
    event = { 'VeryLazy' },
    opts = {},
  },
  {
    'Wansmer/treesj',
    enabled = true,
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    event = { 'VeryLazy' },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      local filenameIcon = function(color, colored)
        return {
          {
            'filetype',
            color = color,
            colored = colored, -- Displays filetype icon in color if set to true
            icon_only = true, -- Display only an icon for filetype
            icon = { align = 'right' }, -- Display filetype icon on the right hand side
            -- icon =    {'X', align='right'}
            -- Icon string ^ in table is ignored in filetype component
          }
        }
      end

      local filenameText = function(color)
        return {
          {
            'filename',
            color = color,
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 3,
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[+]', -- Text to show when the file is modified.
              readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            }
          }
        }
      end

      require('lualine').setup({
        options = {
          component_separators = '|',
          disabled_filetypes = { 'neo-tree', 'Trouble' },
          icons_enabled = true,
          section_separators = '',
          theme = 'onedark',
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        winbar = {
          lualine_a = {},
          lualine_b = filenameIcon({ bg = "" }, true),
          lualine_c = filenameText(''),
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = filenameIcon('Comment', false),
          lualine_c = filenameText('Comment'),
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end
  },
  {
    'nvim-pack/nvim-spectre',
    enabled = true,
    event = { 'VeryLazy' },
    opts = {}
  }
}
