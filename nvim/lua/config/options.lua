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
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- gutters
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = ""

-- indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- invisible chars
vim.opt.list = true
vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.opt.showbreak = "↳  "

-- numberline
vim.opt.number = true
vim.opt.relativenumber = true

-- searching
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- scroll boundaries
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0

-- statusline
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = " "
vim.opt.winbar = " "

-- terminal
vim.opt.termguicolors = true

-- wrapping
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
  virtual_text = false,
})

-- diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- diagnostics in gutter
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " 󰅚", Warn = " 󰀪", Hint = " 󰌶", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    linehl = "",
    numhl = "",
    text = icon,
    texthl = hl,
  })
end
