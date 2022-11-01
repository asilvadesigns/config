local helpGroup = vim.api.nvim_create_augroup('HelpDocs', { clear = true })

-- enable auto compile after saving plugins file
vim.api.nvim_create_autocmd(
  { 'BufWritePost' },
  {
    pattern = 'plugins.lua',
    callback = function()
      local file = vim.fn.expand("<afile>")

      vim.schedule(function()
        vim.cmd('source '..file..' | PackerSync')
      end)
    end
  }
)

-- enable absolute line numbering in normal mode
vim.api.nvim_create_autocmd(
  { 'InsertEnter' },
  { pattern = '*', command = 'set number norelativenumber' }
)

vim.api.nvim_create_autocmd(
  { 'InsertLeave' },
  { pattern = '*', command = 'set number relativenumber' }
)

-- enable numbers in help buffer
vim.api.nvim_create_autocmd(
  { 'WinEnter', 'BufEnter' },
  {
    pattern = '*',
    callback = function()
      vim.schedule(function()
        if vim.bo.filetype == "help" then
          vim.cmd('set number relativenumber')
        end
      end)
    end,
    group = helpGroup
  }
)

