local m = {}

-- backups
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- buffers
vim.opt.splitbelow = true
vim.opt.splitkeep = "cursor"
vim.opt.splitright = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- cursorline
vim.opt.cursorline = true

-- folding
vim.opt.conceallevel = 0
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldcolumn = "0" -- "0" to hide folds. "1" to show.
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- popup menu
vim.opt.pumheight = 10

-- gutters
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = ""
-- vim.opt.statuscolumn = '%=%{v:relnum?v:relnum:v:lnum} '

-- indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- invisible chars
vim.opt.list = false -- TODO: persist via prefs plugin

vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.opt.showbreak = "↳  "

-- numberline
vim.opt.number = false -- TODO: persist via prefs plugin
vim.opt.relativenumber = false -- TODO: persist via prefs plugin

-- searching
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.smartcase = true

-- scroll boundaries
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0

-- sessions
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- statusline && winbar
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = " "
-- vim.opt.winbar = " "

-- terminal
vim.opt.termguicolors = true

-- wrapping
vim.opt.linebreak = true
vim.opt.wrap = false

-- disable
-- vim.g.loaded_2html_plugin = 1
-- vim.g.loaded_getscript = 1
-- vim.g.loaded_getscriptPlugin = 1
-- vim.g.loaded_gzip = 1
-- vim.g.loaded_logipat = 1
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_rrhelper = 1
-- vim.g.loaded_tar = 1
-- vim.g.loaded_tarPlugin = 1
-- vim.g.loaded_vimball = 1
-- vim.g.loaded_vimballPlugin = 1
-- vim.g.loaded_zip = 1
-- vim.g.loaded_zipPlugin = 1
-- vim.g.skip_ts_context_commentstring_module = true

-- diagnostic config
vim.diagnostic.config({
  underline = true,
  virtual_text = true,
})

-- diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostic message" })

-- diagnostics in gutter
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local square = vim.fn.nr2char(0x25aa)

-- local signs = {
--   Error = "󰅚",
--   Warn = "󰀪",
--   Hint = "󰌶",
--   Info = "",
-- }

local signs = {
  Error = square,
  Warn = square,
  Hint = square,
  Info = square,
}

m.signs = signs

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = square,
      [vim.diagnostic.severity.HINT] = square,
      [vim.diagnostic.severity.INFO] = square,
      [vim.diagnostic.severity.WARN] = square,
    },
  },
})

-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   -- vim.fn.sign_define(hl, {
--   --   linehl = "",
--   --   numhl = "",
--   --   text = icon,
--   --   texthl = hl,
--   -- })
-- end

return m
