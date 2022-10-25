local utils = require('core.utils')
local api = vim.api

local copyGroup = api.nvim_create_augroup('YankHighlight', { clear = true })
local cursorGroup = api.nvim_create_augroup('CursorLine', { clear = true })
local helpGroup = api.nvim_create_augroup('HelpDocs', { clear = true })
local loadGroup = api.nvim_create_augroup('Loaders', { clear = true })
local saveGroup = api.nvim_create_augroup('Save', { clear = true })

-- NOTE: just delaying the inevitable. TJ does not approve.
api.nvim_create_autocmd(
  { 'User' },
  { pattern = 'Priority1', group = loadGroup, command = '' }
)

api.nvim_create_autocmd(
  { 'User' },
  { pattern = 'Priority2', group = loadGroup, command = '' }
)

api.nvim_create_autocmd(
  { 'User' },
  { pattern = 'Priority3', group = loadGroup, command = '' }
)

api.nvim_create_autocmd(
  { 'User' },
  { pattern = 'Priority4', group = loadGroup, command = '' }
)

api.nvim_create_autocmd(
  { 'UIEnter' },
  {
    pattern = '*',
    callback = function()
      vim.defer_fn(function()
        vim.api.nvim_exec([[ doautocmd User Priority1 ]], false)
      end, 10)

      vim.defer_fn(function()
        vim.api.nvim_exec([[ doautocmd User Priority2 ]], false)
      end, 20)

      vim.defer_fn(function()
        vim.api.nvim_exec([[ doautocmd User Priority3 ]], false)
      end, 30)

      vim.defer_fn(function()
        vim.api.nvim_exec([[ doautocmd User Priority4 ]], false)
      end, 40)
    end
  }
)

-- NOTE: enable absolute line numbering in normal mode
api.nvim_create_autocmd(
  { 'InsertEnter' },
  { pattern = '*', command = 'set number norelativenumber' }
)

api.nvim_create_autocmd(
  { 'InsertLeave' },
  { pattern = '*', command = 'set number relativenumber' }
)

-- NOTE: enable numbers in help buffer
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

-- NOTE: enable cursorline in active buffer except netrw
api.nvim_create_autocmd(
  { 'WinEnter', 'BufEnter' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype ~= "NvimTree" then
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
        vim.cmd('setlocal nocursorline')
      end
    end,
    group = cursorGroup
  }
)

-- NOTE: enable highlight on copy
api.nvim_create_autocmd(
  { 'TextYankPost' },
  { command = 'silent! lua vim.highlight.on_yank()', group = copyGroup }
)

-- NOTE: save last buffer
api.nvim_create_autocmd(
  { 'BufLeave' },
  {
    pattern = '*',
    callback = function()
      if vim.bo.filetype ~= "NvimTree" then
        local test_id = vim.api.nvim_exec('echo bufnr()', true)
        utils.set_last(test_id)
      end
    end,
    group = saveGroup
  }
)

-- NOTE: enable highlight symbol under cursor
-- @see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
-- if vim.lsp.client.server_capabilities.documentHighlightProvider then
--   vim.cmd [[
--     hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--     hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--     hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--   ]]
--
--   vim.api.nvim_create_augroup('lsp_document_highlight', {
--     clear = false
--   })
--
--   vim.api.nvim_clear_autocmds({
--     buffer = bufnr,
--     group = 'lsp_document_highlight',
--   })
--
--   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--     group = 'lsp_document_highlight',
--     buffer = bufnr,
--     callback = vim.lsp.buf.document_highlight,
--   })
--
--   vim.api.nvim_create_autocmd('CursorMoved', {
--     group = 'lsp_document_highlight',
--     buffer = bufnr,
--     callback = vim.lsp.buf.clear_references,
--   })
-- end
