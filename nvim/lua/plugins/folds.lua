return {
  'kevinhwang91/nvim-ufo',
  enabled = true,
  event = { 'VeryLazy' },
  dependencies = {
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      config = function()
        -- TODO: move to config.icons
        -- 
        -- 
        -- 
        -- 
        -- 
        -- 

        -- NOTE: small icons
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        -- NOTE: large icons
        -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        local builtin = require('statuscol.builtin')
        require('statuscol').setup({
          relculright = true,
          segments = {
            { text = { '%s' },                  click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
          },
        })
      end,
    },
  },
  config = function()
    require('ufo').setup({
      open_fold_hl_timeout = 0, -- don't highlight fold
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    })

    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`.
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  end,
}
