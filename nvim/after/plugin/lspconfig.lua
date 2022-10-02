local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

-- local protocol = require('vim.lsp.protocol')
-- 
-- nvim_lsp.sumneko_lua.setup({
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { 'vim' }
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true)
--       }
--     }
--   }
-- })
-- 
-- 
