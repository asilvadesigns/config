local api = vim.api

local copyGroup = api.nvim_create_augroup('YankHighlight', { clear = true })
local cursorGroup = api.nvim_create_augroup('CursorLine', { clear = true })
local helpGroup = api.nvim_create_augroup('HelpDocs', { clear = true })

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

-- NOTE: enable highlight on copy
api.nvim_create_autocmd(
  { 'TextYankPost' },
  { command = 'silent! lua vim.highlight.on_yank()', group = copyGroup }
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
