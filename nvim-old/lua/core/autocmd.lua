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

-- NOTE: enable highlight on copy
vim.api.nvim_create_autocmd(
  { 'TextYankPost' },
  { command = 'silent! lua vim.highlight.on_yank()', group = copyGroup }
)
