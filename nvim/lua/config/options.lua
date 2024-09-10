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
-- vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.opt.foldcolumn = "1" -- "0" to hide folds. "1" to show.
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- popup menu
vim.opt.pumheight = 10

-- indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- invisible chars
vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.opt.list = false -- TODO: persist via prefs plugin

vim.opt.showbreak = "↳  "

-- numberline
vim.opt.number = true -- TODO: persist via prefs plugin
vim.opt.relativenumber = true -- TODO: persist via prefs plugin

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

-- scroll behavior
vim.opt.smoothscroll = true

-- sessions
vim.opt.sessionoptions = "buffers,curdir,winsize,winpos"

-- statusline && winbar
vim.opt.laststatus = 0
local str = string.rep("—", 500)
vim.opt.statusline = str
vim.opt.signcolumn = "yes"
vim.opt.winbar = " "

-- terminal
vim.opt.termguicolors = true

-- wrapping
vim.opt.linebreak = true
vim.opt.wrap = false

-- diagnostic keymaps
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostic message" })

-- jumplist
vim.opt.jumpoptions = "view"

-- diagnostics in gutter
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local square = vim.fn.nr2char(0x25aa)

local signs = {
  Error = square,
  Warn = square,
  Hint = square,
  Info = square,
}

m.signs = signs

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
  })
end

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = square,
      [vim.diagnostic.severity.HINT] = square,
      [vim.diagnostic.severity.INFO] = square,
      [vim.diagnostic.severity.WARN] = square,
    },
    -- NOTE: cool to highlight but too much.
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    },
  },
})

return m
