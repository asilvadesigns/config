-- Autocmds
local copyGroup = vim.api.nvim_create_augroup('YankGroup', { clear = true })
local helpGroup = vim.api.nvim_create_augroup('HelpGroup', { clear = true })
local lineGroup = vim.api.nvim_create_augroup('lineGroup', { clear = true })

-- enable cursorline in active buffer except netrw
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'NvimTree' then
      vim.cmd('setlocal cursorline')
    end
  end,
  group = lineGroup,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'NvimTree' then
      vim.cmd('setlocal nocursorline')
    end
  end,
  group = lineGroup,
})

-- enable numbers in help buffer
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      if vim.bo.filetype == 'help' then
        vim.cmd('set number relativenumber')
      end
    end)
  end,
  group = helpGroup,
})

-- enable highlight on copy
vim.api.nvim_create_autocmd({ 'TextYankPost' }, { command = 'silent! lua vim.highlight.on_yank()', group = copyGroup })

-- Mappings
local keymap_opts = { noremap = true, silent = true }
local keymap_opts_with_expr = { noremap = true, expr = true, silent = true }

-- leader
vim.g.mapleader = ','

-- better editing line movements
vim.keymap.set('i', '<c-l>', '<END>', keymap_opts)
vim.keymap.set('i', '<c-h>', '<HOME>', keymap_opts)

-- better escape using jk in insert and terminal mode
-- vim.keymap.set('i', 'kj', '<ESC>', defaults)
-- vim.keymap.set('t', 'kj', '<C-\\><C-n>', defaults)

-- better navigation in windows
vim.keymap.set('n', '<C-h>', '<C-w>h', keymap_opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', keymap_opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', keymap_opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', keymap_opts)
vim.keymap.set('n', '<leader>q', '<C-w>q', keymap_opts)

-- better navigation with mouse
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>', keymap_opts)
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>', keymap_opts)
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>', keymap_opts)

-- better navigation in line wraps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)

-- better indent
vim.keymap.set('v', '<', '<gv', keymap_opts)
vim.keymap.set('v', '>', '>gv', keymap_opts)

-- paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dP', keymap_opts)

-- switch buffer
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', keymap_opts)
vim.keymap.set('n', '<S-l>', ':bnext<CR>', keymap_opts)

-- move selected line / block of text in visual mode
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", keymap_opts)
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", keymap_opts)

-- resizing panes
vim.keymap.set('n', '<Left>', ':vertical resize +1<CR>', keymap_opts)
vim.keymap.set('n', '<Right>', ':vertical resize -1<CR>', keymap_opts)
vim.keymap.set('n', '<Up>', ':resize -1<CR>', keymap_opts)
vim.keymap.set('n', '<Down>', ':resize +1<CR>', keymap_opts)

-- NOTE: using telescope file_browser now.
-- using netrw
-- @see: https://superuser.com/questions/1531456/how-to-reveal-a-file-in-vim-netrw-treeview
-- vim.keymap.set(
--   'n',
--   '<leader>x',
--   ":let @/=expand('%:t') <Bar> execute 'Explore' expand('%:h') <Bar> normal n<CR>",
--   keymap_opts
-- )

-- Options
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 1
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldcolumn = '3'
-- vim.opt.foldenable = false
-- vim.opt.foldlevel = 20
-- vim.opt.foldmethod = 'indent'
-- vim.opt.foldnestmax = 3

vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 0
vim.opt.list = true
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 0
vim.opt.shiftwidth = 2
vim.opt.showbreak = '↳  '
vim.opt.showmode = false
vim.opt.showtabline = 0 -- none for now
vim.opt.sidescrolloff = 6
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.writebackup = false

-- vim.opt.statusline = '...'
-- vim.opt.winbar = '...'

-- Plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins Internal
require('plugins.escape').setup()

-- Plugins External
local plugins = {
  autopairs = {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  better_escape = {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup({
        clear_empty_lines = false,  -- clear line after escaping if there is only whitespace
        keys = '<Esc>',             -- keys used for escaping, if it is a function will use the result everytime
        mapping = { 'kj' },         -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      })
    end,
  },
  colorizer = {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  comment = {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  completion = {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  completion_lsp = {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup()
        end,
      },
      'folke/neodev.nvim',
    },
  },
  filetype = {
    'nathom/filetype.nvim',
    config = function()
      -- @see: https://github.com/nathom/filetype.nvim/issues/68
      local function bash_literal()
        vim.bo.filetype = 'sh'
        vim.b.is_bash = true
      end

      require('filetype').setup({
        overrides = {
          complex = {
            ['.*/.bash.*'] = bash_literal,
          },
        },
      })
    end,
  },
  fugitive = {
    'tpope/vim-fugitive',
  },
  leap = {
    'ggandor/leap.nvim',
    config = function()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      vim.api.nvim_set_hl(0, 'LeapMatch', {
        fg = 'white', -- set to black for light themes
        bold = true,
        nocombine = true,
      })

      require('leap').opts.highlight_unlabeled_phase_one_targets = true

      vim.keymap.set('n', ';', "<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>")
    end,
  },
  lualine = {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          always_divide_middle = true,
          component_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = {}, winbar = { 'NvimTree' } },
          globalstatus = true,
          icons_enabled = true,
          ignore_focus = {},
          refresh = { statusline = 100, tabline = 100, winbar = 100 },
          section_separators = { left = '', right = '' },
          theme = 'auto',
        },
        sections = {
          lualine_a = {},
          -- lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        -- , color = 'LineNr'
        winbar = {
          lualine_a = {},
          lualine_b = { { 'filename', path = 3 } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {},
        inactive_winbar = {
          lualine_a = {},
          lualine_b = { { 'filename', path = 3 } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  multiple_cursors = {
    'mg979/vim-visual-multi',
    config = function()
    end,
  },
  neotree = {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup()
    end,
  },
  null = {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup({
        sources = {
          -- -- eslint
          -- require('null-ls').builtins.code_actions.eslint,
          -- lua
          require('null-ls').builtins.formatting.stylua,
          -- prettier
          require('null-ls').builtins.formatting.prettier,
        },
      })
    end,
  },
  nvimtree = {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        git = {
          enable = false,
          ignore = true,
        },
        update_cwd = false,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        renderer = {
          indent_width = 2,
          indent_markers = {
            enable = true,
          },
          icons = {
            git_placement = 'after',
            glyphs = {
              git = {
                unstaged = '',
                staged = '',
                unmerged = '',
                renamed = '',
                untracked = '',
                deleted = '-',
                ignored = '',
              },
            },
          },
        },
        view = {
          -- hide_root_folder = true,
          width = 40,
        },
      })

      -- setup keybindings
      vim.keymap.set('n', '<C-S-j>', '<CMD>NvimTreeToggle<CR>')
      vim.keymap.set('n', '<leader>j', '<CMD>NvimTreeFindFile<CR>')
    end,
  },
  onedark = {
    {
      'navarasu/onedark.nvim',
      priority = 1000,
      config = function()
        require('onedark').setup({ style = 'dark' })
        require('onedark').load()

        -- reset NvimTree
        -- vim.cmd('hi! clear NvimTreeEndOfBuffer')
        -- vim.cmd('hi! clear NvimTreeNormal')
        -- vim.cmd('hi! clear NvimTreeRootFolder')
        -- vim.cmd('hi! clear NvimTreeVertSplit')
        -- vim.cmd('hi! link NvimTreeEmptyFolderName Normal')
        -- vim.cmd('hi! link NvimTreeFolderName Normal')
        -- vim.cmd('hi! link NvimTreeIndentMarker Comment')
        -- vim.cmd('hi! link NvimTreeOpenedFolderName Normal')

        -- reset Telescope
        vim.cmd('hi! link TelescopeNormal NormalFloat')
        vim.cmd('hi! link TelescopeBorder FloatBorder')
        vim.cmd('hi! link TelescopePreviewNormal NormalFloat')
        vim.cmd('hi! link TelescopeResultsNormal NormalFloat')
      end,
    },
  },
  onedarkpro = {
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Ensure it loads first
    config = function()
      local theme = require('onedarkpro')
      local color = require('onedarkpro.helpers')

      theme.setup({
        colors = {
          dark = {
            telescope_prompt = "require('onedarkpro.helpers').darken('bg', 1, 'onedark')",
            telescope_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')",
            telescope_preview = "require('onedarkpro.helpers').darken('bg', 6, 'onedark')",
            telescope_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
          },
          light = {
            telescope_prompt = "require('onedarkpro.helpers').darken('bg', 2, 'onelight')",
            telescope_results = "require('onedarkpro.helpers').darken('bg', 5, 'onelight')",
            telescope_preview = "require('onedarkpro.helpers').darken('bg', 7, 'onelight')",
            telescope_selection = "require('onedarkpro.helpers').darken('bg', 9, 'onelight')",
          },
        },
        highlights = {
          TelescopeBorder = {
            fg = '${telescope_results}',
            bg = '${telescope_results}',
          },
          TelescopePromptBorder = {
            fg = '${telescope_prompt}',
            bg = '${telescope_prompt}',
          },
          TelescopePromptCounter = { fg = '${fg}' },
          TelescopePromptNormal = { fg = '${fg}', bg = '${telescope_prompt}' },
          TelescopePromptPrefix = {
            fg = '${purple}',
            bg = '${telescope_prompt}',
          },
          TelescopePromptTitle = {
            fg = '${telescope_prompt}',
            bg = '${purple}',
          },
          TelescopePreviewTitle = {
            fg = '${telescope_results}',
            bg = '${green}',
          },
          TelescopeResultsTitle = {
            fg = '${telescope_results}',
            bg = '${telescope_results}',
          },
          TelescopeMatching = { fg = '${blue}' },
          TelescopeNormal = { bg = '${telescope_results}' },
          TelescopeSelection = { bg = '${telescope_selection}' },
          TelescopePreviewNormal = { bg = '${telescope_preview}' },
          TelescopePreviewBorder = { fg = '${telescope_preview}', bg = '${telescope_preview}' },
          -- custom
          CursorLineNr = { fg = '${fg}', bg = '${cursorline}' },
          WinSeparator = { fg = '${bg}' },
          -- colors used in hover
          DiagnosticError = { fg = '${fg}' },
          DiagnosticHint = { fg = '${fg}' },
          DiagnosticInfo = { fg = '${fg}' },
          DiagnosticWarn = { fg = '${fg}' },
          -- colors used in number sign
          DiagnosticSignError = { fg = '${fg}' },
          DiagnosticSignHint = { fg = '${fg}' },
          DiagnosticSignInfo = { fg = '${fg}' },
          DiagnosticSignWarn = { fg = '${fg}' },
        },
        options = {
          cursorline = true,
        },
        styles = {
          comments = 'italic',
          conditionals = 'NONE',
          constants = 'NONE',
          functions = 'NONE',
          keywords = 'NONE',
          methods = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          parameters = 'NONE',
          strings = 'NONE',
          types = 'NONE',
          variables = 'NONE',
          virtual_text = 'NONE',
        },
      })
      vim.cmd('colorscheme onedark')

      -- reset NvimTree
      -- vim.cmd('hi! clear NvimTreeEndOfBuffer')
      -- vim.cmd('hi! clear NvimTreeNormal')
      -- vim.cmd('hi! clear NvimTreeRootFolder')
      -- vim.cmd('hi! clear NvimTreeVertSplit')
      -- vim.cmd('hi! link NvimTreeEmptyFolderName Normal')
      -- vim.cmd('hi! link NvimTreeFolderName Normal')
      -- vim.cmd('hi! link NvimTreeIndentMarker Comment')
      -- vim.cmd('hi! link NvimTreeOpenedFolderName Normal')

      -- reset Telescope
      vim.cmd('hi! link TelescopeNormal NormalFloat')
      vim.cmd('hi! link TelescopeBorder FloatBorder')
      vim.cmd('hi! link TelescopePreviewNormal NormalFloat')
      vim.cmd('hi! link TelescopeResultsNormal NormalFloat')
    end,
  },
  scrollbar = {
    'dstein64/nvim-scrollview',
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
  session = {
    'olimorris/persisted.nvim',
    config = function()
      require('persisted').setup({
        autoload = true,
      })
    end,
  },
  surround = {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  telescope = {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- borderchars = {
      --   { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      --   prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
      --   results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      --   preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      -- },
      -- NOTE: previously used file browser options
      -- file_browser = {
      --   hijack_netrw = true,
      --   preview = false,
      --   theme = 'ivy',
      --   mappings = {
      --     ['i'] = {
      --       ['<C-u>'] = false,
      --       ['<esc>'] = require('telescope.actions').close,
      --     },
      --   },
      -- },
      require('telescope').setup({
        defaults = require('telescope.themes').get_dropdown({
          borderchars = {
            { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
          },
          preview = false,
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<esc>'] = require('telescope.actions').close,
            },
          },
        }),
        extensions = {
          file_browser = require('telescope.themes').get_dropdown({
            borderchars = {
              { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
              prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
              results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
              preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            },
            display_stat = false,
            preview = false,
            mappings = {
              i = {
                ['<C-u>'] = false,
                ['<esc>'] = require('telescope.actions').close,
              },
            },
          }),
          fzf = {
            case_mode = 'smart_case',       -- or 'ignore_case', 'respect_case'
            fuzzy = true,                   -- false will only do exact matching
            override_file_sorter = true,    -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
          },
        },
        pickers = {
          oldfiles = {
            only_cwd = true,
          },
        },
      })

      pcall(require('telescope').load_extension, 'file_browser')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'persisted')

      vim.keymap.set('n', '<leader>a', ':Telescope commands<CR>')
      vim.keymap.set('n', '<leader>b', ':Telescope builtin<CR>')
      vim.keymap.set('n', '<leader>e', ':Telescope oldfiles<CR>')
      vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>')
      vim.keymap.set('n', '<leader>g', ':Telescope git_files<CR>')

      vim.api.nvim_set_keymap(
        'n',
        '<leader>x',
        ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
        { noremap = true }
      )
    end,
  },
  telescope_browser = {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  telescope_fzf = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
  tmux = {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, keymap_opts)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown, keymap_opts)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, keymap_opts)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, keymap_opts)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive, keymap_opts)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext, keymap_opts)
    end,
  },
  toggleterm = {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()

      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], keymap_opts)
    end,
  },
  treesitter = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end,
  },
  treesitter_autopairs = {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  treesitter_context = {
    'nvim-treesitter/playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require('treesitter-context').setup()
    end,
  },
  treesitter_playground = {
    'nvim-treesitter/playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          additional_vim_regex_highlighting = false,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
      })
    end,
  },
  trouble = {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('trouble').setup({
        use_diagnostic_signs = true,
        auto_open = false,
      })
    end,
  },
  ufo = {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
              { text = { '%s' },                  click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          })
        end,
      },
    },
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })

      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end,
  },
}

require('lazy').setup({
  plugins.autopairs,
  plugins.better_escape,
  plugins.colorizer,
  plugins.comment,
  plugins.completion,
  plugins.completion_lsp,
  plugins.filetype,
  plugins.fugitive,
  plugins.leap,
  -- plugins.lualine,
  plugins.multiple_cursors,
  plugins.null,
  plugins.nvimtree,
  plugins.onedarkpro,
  plugins.scrollbar,
  plugins.session,
  plugins.surround,
  plugins.telescope,
  plugins.telescope_browser,
  plugins.telescope_fzf,
  plugins.tmux,
  plugins.toggleterm,
  plugins.treesitter,
  plugins.treesitter_autopairs,
  plugins.treesitter_context,
  plugins.treesitter_playground,
  plugins.trouble,
  plugins.ufo,
}, {
  dev = {
    path = '~.config/nvim/lua/plugins',
  },
})

-- Plugins Options
require('nvim-treesitter.configs').setup({
  -- Add languages to be installed here that you want installed for treesitter "help"
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim' },
  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
})

-- Diagnostic config
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- NOTE: I don't use these.
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Diagnostics in gutter
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = {
  Error = '',
  Hint = '',
  Info = '',
  Warn = '',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
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

  local format_lsp = function()
    vim.lsp.buf.format({ async = true })
  end

  nmap('<leader>m', format_lsp, 'Format')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('ge', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- NOTE: was 'K' but I like gh
  nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
  -- NOTE:was '<C-K>' but I like gs
  nmap('gs', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format({ async = true })
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  cssls = {},
  eslint = {},
  html = {},
  jsonls = {},
  pyright = {},
  yamlls = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

local root_dir = require('lspconfig.util').root_pattern('.git')
mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = root_dir,
      settings = servers[server_name],
    })
  end,
})

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.setup()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol',
      maxwidth = 50,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
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
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
})
