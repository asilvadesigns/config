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

-- enable cursorline in active buffer except netrw
api.nvim_create_autocmd(
  { 'WinEnter' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype ~= "netrw" then
        vim.cmd('set cursorline')
        return
      end
    end,
    group = cursorGroup
  }
)

api.nvim_create_autocmd(
  { 'WinLeave' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype ~= "netrw" then
        vim.cmd('set nocursorline')
        return
      end
    end,
    group = cursorGroup
  }
)

-- enable highlight on copy
api.nvim_create_autocmd(
  { 'TextYankPost' },
  { command = 'silent! lua vim.highlight.on_yank()', group = copyGroup }
)
