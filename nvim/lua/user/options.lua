-- editing
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.expandtab = true -- spaces instead of tabs
vim.opt.shiftwidth = 2 -- shift 2 spaces when using tab
vim.opt.smartindent = true -- autoindent new lines
vim.opt.tabstop = 2 -- 1 tab == 2 spaces

-- search
vim.opt.ignorecase = true -- case insensitive search...
vim.opt.inccommand = 'split' --show search in split
vim.opt.smartcase = true -- ...unless we use upperase

-- theme
vim.opt.cursorline = true -- show cursorline
vim.opt.laststatus = 3 -- global status line ftw
vim.opt.number = true -- show number line
vim.opt.relativenumber = true -- relative number line
vim.opt.scrolloff = 5 -- min lines to keep from cursor
vim.opt.signcolumn = 'yes' -- always show signs
vim.opt.splitbelow = true -- vertical split to the bottom
vim.opt.splitright = true -- horizontal split to the right
vim.opt.termguicolors = true -- enable rgb color in TUI
vim.opt.wrap = false -- do not wrap
