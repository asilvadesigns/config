local api = vim.api

local copyGroup = api.nvim_create_augroup('YankHighlight', { clear = true })
local cursorGroup = api.nvim_create_augroup('CursorLine', { clear = true })
local helpGroup = api.nvim_create_augroup('HelpDocs', { clear = true })


-- enable absolute line numbering in normal mode
api.nvim_create_autocmd(
  { 'InsertEnter' },
  { pattern = '*', command = 'set number norelativenumber' }
)

api.nvim_create_autocmd(
  { 'InsertLeave' },
  { pattern = '*', command = 'set nonumber relativenumber' }
)

-- enable numbers in help buffer
api.nvim_create_autocmd(
  { 'WinEnter', 'BufEnter' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype == "help" then
        vim.cmd('set number relativenumber')
      end
    end,
    group = helpGroup
  }
)

-- enable cursorline in active buffer except netrw
api.nvim_create_autocmd(
  { 'WinEnter', 'BufEnter' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype ~= "NvimTree" then
        -- vim.notify('enter:: not nvim tree')
        vim.cmd('setlocal cursorline')
      end
    end,
    group = cursorGroup
  }
)

api.nvim_create_autocmd(
  { 'WinLeave', 'BufLeave' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype ~= "NvimTree" then
        -- vim.notify('leave:: not nvim tree')
        vim.cmd('setlocal nocursorline')
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
