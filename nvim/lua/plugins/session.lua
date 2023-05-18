return {
  {
    "folke/persistence.nvim",
    enabled = true,
    event = { 'VeryLazy' },
    module = "persistence",
    config = function()
      require("persistence").setup()

      local session_load = function()
        require("persistence").load()
      end

      vim.api.nvim_create_user_command("SessionLoad", session_load, {})
      vim.api.nvim_create_user_command("LoadSession", session_load, {})
      vim.keymap.set('n', '<leader>sl', session_load, { noremap = true, desc = '[s]ession [l]oad' })

      -- vim.api.nvim_create_autocmd({ 'VeryLazy' }, {
      --   callback = function()
      --     print('yo... whats going on')
      --   end
      -- })

      -- if next(vim.fn.argv()) == nil then
      --   require('persistence').load()
      -- end

      -- vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
      --   callback = function()
      --     session_load()
      --   end,
      -- })
    end,
  },
  -- NOTE: nice b/c of automated session loading
  -- {
  --   'olimorris/persisted.nvim',
  --   config = function()
  --     require('persisted').setup({
  --       autoload = true,
  --     })
  --   end,
  -- },
}
