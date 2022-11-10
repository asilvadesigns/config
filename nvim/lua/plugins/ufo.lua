local M = {}

M.setup = function()
  -- @see: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

  vim.o.foldcolumn = '2'
  vim.o.foldenable = true
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldnestmax = 2

  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  require('ufo').setup({
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end,
  })

  -- enable fold lines like comments
  vim.cmd('highlight! link FoldColumn LineNr')
end

return M
