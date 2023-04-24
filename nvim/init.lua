-- ########################################
-- KEYMAPS
-- ########################################
local keymap_opts = { noremap = true } 
local keymap_opts_with_expr = { noremap = true, expr = true } 

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
vim.keymap.set('n', '<leader>c', '<C-w>q', { noremap = true, desc = '[c]lose buffer'})

-- better navigation with mouse
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>', keymap_opts)
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>', keymap_opts)
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>', keymap_opts)
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>', keymap_opts)

-- better navigation in line wraps
--vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", keymap_opts_with_expr)
--vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", keymap_opts_with_expr)

-- better indent
vim.keymap.set('v', '<', '<gv', keymap_opts)
vim.keymap.set('v', '>', '>gv', keymap_opts)

-- paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dP', keymap_opts)

-- switch buffer
-- vim.keymap.set('n', '<S-h>', ':bprevious<CR>', keymap_opts)
-- vim.keymap.set('n', '<S-l>', ':bnext<CR>', keymap_opts)

-- move selected line / block of text in visual mode
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", keymap_opts)
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", keymap_opts)

-- resizing panes
vim.keymap.set('n', '<Left>', ':vertical resize +1<CR>', keymap_opts)
vim.keymap.set('n', '<Right>', ':vertical resize -1<CR>', keymap_opts)
vim.keymap.set('n', '<Up>', ':resize -1<CR>', keymap_opts)
vim.keymap.set('n', '<Down>', ':resize +1<CR>', keymap_opts)

-- ########################################
-- OPTIONS
-- ########################################
-- backups
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- buffers
vim.opt.splitbelow = true
vim.opt.splitright = true

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- cursorline
vim.opt.cursorline = true

-- folding
vim.opt.conceallevel = 0

-- gutters
vim.opt.signcolumn = 'yes'

-- indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- invisible chars
vim.opt.list = true
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.showbreak = '↳  '

-- numberline
vim.opt.number = true
vim.opt.relativenumber = true

-- searching
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- scroll boundaries
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 6

-- statusline
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = '...'
vim.opt.winbar = '...'

-- terminal
vim.opt.termguicolors = true

-- wrapping
vim.opt.wrap = false

-- ########################################
-- PLUGINS
-- ########################################
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

require("lazy").setup({
  'folke/neodev.nvim',
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'nvim-treesitter/playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require('treesitter-context').setup()
    end,
  },
  {
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
  {
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
  {
    'folke/noice.nvim',
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
    'tpope/vim-fugitive',
  },
  {
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
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      vim.api.nvim_set_hl(0, 'LeapMatch', {
        fg = 'white', -- set to black for light themes
        bold = true,
        nocombine = true,
      })

      -- require('leap').add_default_mappings()
      -- require('leap').setup()
      -- require('leap').opts.highlight_unlabeled_phase_one_targets = true

      vim.keymap.set('n', ';', "<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>")
    end,
  },
  {
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
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
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
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'ishan9299/nvim-solarized-lua',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme solarized-flat')
      vim.cmd('hi EndOfBuffer guifg=bg')
      vim.cmd('hi WinSeparator guifg=bg')
      vim.cmd('hi! link FoldColumn LineNr')
    end
  },
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    config = function()
      local theme = require('onedarkpro')
      -- theme.setup()
      -- vim.cmd('colorscheme onedark')
    end
  },
  {
    'olimorris/persisted.nvim',
    config = function()
      require('persisted').setup({
        autoload = true,
      })
    end,
  },
},
{
  performance = {
    rtp = {
      disabled_plugins = {
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "rrhelper",
        "tar",
        "tarPlugin",
        "tohtml",
        "vimball",
        "vimballPlugin",
        "tutor",
        "zip",
        "zipPlugin",
      }
    }
  }
})
