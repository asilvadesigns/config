-- OPTIONS | FILES
vim.opt.swapfile = false            -- disable swap file

-- OPTIONS | SEARCH
vim.opt.ignorecase = true

-- OPTIONS | SYSTEM
vim.opt.clipboard = 'unnamedplus'   -- copy/paste to system clipboard

-- OPTIONS | TABS
vim.opt.expandtab = true	          -- use spaces instead of tabs
vim.opt.shiftwidth = 2 		          -- shift 2 spaces when using tab
vim.opt.smartindent = true 	        -- autoindent new lines
vim.opt.tabstop = 2 		            -- 1 tab == 2 spaces

-- OPTIONS | UI
vim.opt.wrap = false
vim.opt.cursorline = true           -- enable cursorline
vim.opt.laststatus = 3              -- global status line ftw
vim.opt.number = true               -- use relative line numbers
vim.opt.relativenumber = true       -- use relative line numbers
vim.opt.signcolumn = 'yes'          -- always show signs
vim.opt.splitbelow = true           -- use vertical split to the bottom
vim.opt.splitright = true           -- use horizontal split to the right
vim.opt.termguicolors = true        -- enable rgb color in TUI
