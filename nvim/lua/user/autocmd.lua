local api = vim.api

local copyGroup = api.nvim_create_augroup('YankHighlight', { clear = true })
local cursorGroup = api.nvim_create_augroup('CursorLine', { clear = true })

-- enable absolute line numbering in normal mode
api.nvim_create_autocmd(
	{ 'InsertEnter' },
	{ pattern = '*', command = 'set number norelativenumber' }
)

api.nvim_create_autocmd(
	{ 'InsertLeave' },
	{ pattern = '*', command = 'set nonumber relativenumber' }
)

-- enable cursorline in active window
api.nvim_create_autocmd(
	{ 'InsertLeave', 'WinEnter' },
	{ pattern = '*', command = 'set cursorline', group = cursorGroup }
)

api.nvim_create_autocmd(
	{ 'InsertEnter', 'WinLeave' },
	{ pattern = '*', command = 'set nocursorline', group = cursorGroup }
)

-- enable highlight on copy
api.nvim_create_autocmd(
  { 'TextYankPost' },
  { command = 'silent! lua vim.highlight.on_yank()', group = copyGroup }
)
