local copyGroup = vim.api.nvim_create_augroup('YankGroup', { clear = true })
local helpGroup = vim.api.nvim_create_augroup('HelpGroup', { clear = true })
local lineGroup = vim.api.nvim_create_augroup('lineGroup', { clear = true })
local loadGroup = vim.api.nvim_create_augroup('loadGroup', { clear = true })

-- enable deferred loading
vim.api.nvim_create_autocmd({ 'User' }, { pattern = 'Defer', command = '', group = loadGroup })

vim.api.nvim_create_autocmd({ 'UIEnter' }, {
  pattern = '*',
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec([[ doautocmd User Defer ]], false)
    end, 20)
  end,
})

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

-- enable auto compile after saving plugins file
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = '**/core/plugins.lua',
  callback = function()
    local file = vim.fn.expand('<afile>')

    vim.inspect(file)

    vim.schedule(function()
      vim.cmd('source ' .. file .. ' | PackerSync')
    end)
  end,
})

-- enable absolute line numbering in normal mode
vim.api.nvim_create_autocmd({ 'InsertEnter' }, { pattern = '*', command = 'set number norelativenumber' })

vim.api.nvim_create_autocmd({ 'InsertLeave' }, { pattern = '*', command = 'set number relativenumber' })

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
