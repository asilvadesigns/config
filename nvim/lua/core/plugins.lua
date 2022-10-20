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
  'neovim/nvim-lspconfig',
  event = { 'User PackerComplete', 'User Priority2' },
  config = function()
    require('plugins.completion')
  end
})

packer.use({
  'folke/trouble.nvim',
  event = { 'User PackerComplete', 'User Priority2' },
  config = function()
    require('trouble').setup({})
  end
})

packer.use({
  'nvim-telescope/telescope-fzf-native.nvim',
  run = 'make',
  event = { 'User PackerComplete', 'User Priority3' },
})

packer.use({
  'nvim-telescope/telescope.nvim',
  event = { 'User PackerComplete', 'User Priority3' },
  config = function()
    require('plugins.telescope')
  end
})

if (state.should_sync) then
  utils.reload()
end

-- at this point I know packer exists... but packer is asynchronous... so how can I react to a plugin being loaded....

-- return require('packer').startup(function(use)
--   use({
--     'ishan9299/nvim-solarized-lua',
--     config = function()
--       -- NOTE: disabled for now
--       -- vim.cmd('colorscheme solarized-flat')
--     end
--   })
--
--   use({
--     'nvim-telescope/telescope.nvim',
--     config = function()
--       require('telescope').setup({
--         defaults = {
--           borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
--           layout_config = {
--             center = { height = 0.5, width = 0.8 }
--           },
--           layout_strategy = 'center',
--           mappings = { i = { ["<C-u>"] = false }, },
--           sorting_strategy = "ascending",
--         }
--       })
--
--       function project_files()
--         local opts = {}
--         local git_ok = pcall(require('telescope.builtin').git_files, opts)
--         if not git_ok then require('telescope.builtin').find_files(opts) end
--       end
--
--       vim.keymap.set('n', '<LEADER>a', '<CMD>Telescope commands<CR>')
--       vim.keymap.set('n', '<LEADER>b', '<CMD>Telescope buffers<CR>')
--       vim.keymap.set('n', '<LEADER>c', '<CMD>Telescope colorscheme<CR>')
--       vim.keymap.set('n', '<LEADER>e', '<CMD>Telescope oldfiles<CR>')
--       vim.keymap.set('n', '<LEADER>f', '<CMD>lua project_files()<CR>')
--       vim.keymap.set('n', '<LEADER>l', '<CMD>Telescope current_buffer_fuzzy_find<CR>')
--     end
--   })
--
--   use({
--     'kyazdani42/nvim-tree.lua',
--     config = function()
--       require('nvim-tree').setup({
--         respect_buf_cwd = true,
--         update_cwd = true,
--         update_focused_file = {
--           enable = true,
--           ignore_list = {},
--           update_cwd = true,
--         },
--         git = {
--           enable = false,
--           ignore = false
--         },
--         view = { width = 40 },
--       })
--
--       vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
--       vim.keymap.set('n', '<LEADER>j', '<CMD>NvimTreeFindFile<CR>')
--     end
--   })
--
--   use({
--     'neovim/nvim-lspconfig',
--     requires = {
--       'L3MON4D3/LuaSnip',
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-cmdline',
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-path',
--       'hrsh7th/nvim-cmp',
--       'neovim/nvim-lspconfig',
--       'saadparwaiz1/cmp_luasnip',
--     },
--     config = function()
--       local cmp = require('cmp')
--       local lspconfig = require('lspconfig')
--
--       cmp.setup({
--         snippet = {
--           -- REQUIRED - you must specify a snippet engine
--           expand = function(args)
--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--           end,
--         },
--         window = {
--           -- completion = cmp.config.window.bordered(),
--           -- documentation = cmp.config.window.bordered(),
--         },
--         mapping = cmp.mapping.preset.insert({
--           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-f>'] = cmp.mapping.scroll_docs(4),
--           ['<C-Space>'] = cmp.mapping.complete(),
--           ['<C-e>'] = cmp.mapping.abort(),
--           ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--         }),
--         sources = cmp.config.sources({
--           { name = 'nvim_lsp' },
--           { name = 'luasnip' },
--         }, {
--           { name = 'buffer' },
--           { name = 'path' },
--         })
--       })
--
--       local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
--       local lsp_flags = { debounce_text_changes = 150 }
--       local lsp_on_attach = function(client, bufnr)
--         local bufopts = { noremap = true, silent = true, buffer = bufnr }
--
--         -- Enable completion triggered by <c-x><c-o>
--         vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--         -- vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
--         -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
--         -- vim.keymap.set('n', '<leader>m', vim.lsp.buf.format, bufopts)
--         -- vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
--         -- vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
--         -- vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next)
--         -- vim.keymap.set('n', '<leader>np', vim.diagnostic.goto_prev)
--         -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--         vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--         vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--         vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--         vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
--       end
--
--       -- NOTE: available servers
--       -- @see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--       require('lspconfig')['jsonls'].setup({
--         capabilities = lsp_capabilities,
--         flags = lsp_flags,
--         on_attach = lsp_on_attach,
--       })
--
--       -- @see: https://github.com/sumneko/lua-language-server
--       require('lspconfig')['sumneko_lua'].setup({
--         capabilities = lsp_capabilities,
--         flags = lsp_flags,
--         on_attach = lsp_on_attach,
--         settings = {
--           Lua = {
--             diagnostics = {
--               globals = { 'vim' }
--             },
--             workspace = {
--               library = vim.api.nvim_get_runtime_file('', true)
--             }
--           }
--         }
--       })
--
--       -- @see: https://github.com/typescript-language-server/typescript-language-server
--       require('lspconfig')['tsserver'].setup({
--         capabilities = lsp_capabilities,
--         flags = lsp_flags,
--         on_attach = lsp_on_attach,
--       })
--
--       -- -- NOTE: Diagnostics in gutter
--       -- -- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
--       -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
--       -- for type, icon in pairs(signs) do
--       --   local hl = "DiagnosticSign" .. type
--       --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--       -- end
--
--       -- -- NOTE: Icons in completion menu
--       -- -- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#completion-kinds
--       -- local icons = {
--       --   Class = " ",
--       --   Color = " ",
--       --   Constant = " ",
--       --   Constructor = " ",
--       --   Enum = "了 ",
--       --   EnumMember = " ",
--       --   Field = " ",
--       --   File = " ",
--       --   Folder = " ",
--       --   Function = " ",
--       --   Interface = "ﰮ ",
--       --   Keyword = " ",
--       --   Method = "ƒ ",
--       --   Module = " ",
--       --   Property = " ",
--       --   Snippet = "﬌ ",
--       --   Struct = " ",
--       --   Text = " ",
--       --   Unit = " ",
--       --   Value = " ",
--       --   Variable = " ",
--       -- }
--       --
--       -- local kinds = vim.lsp.protocol.CompletionItemKind
--       -- for i, kind in ipairs(kinds) do
--       --   kinds[i] = icons[kind] or kind
--       -- end
--     end
--   })
--
--   -- if ready then
--   --   require('packer').sync()
--   -- end
-- -- end)
