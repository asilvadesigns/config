local M = {}

M.setup = function()
  local defaults = { silent = true }

  require('lspsaga').setup({
    code_action_icon = '',
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- same as nvim-lightbulb but async
    code_action_lightbulb = {
      enable = true,
      enable_in_insert = false,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = false,
    },
  })

  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', defaults)

  -- Code action
  vim.keymap.set({ 'n', 'v' }, '<C-.>', '<cmd>Lspsaga code_action<CR>', defaults)

  -- Rename
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', defaults)

  -- Peek Definition
  -- you can edit the definition file in this flaotwindow
  -- also support open/vsplit/etc operation check definition_action_keys
  -- support tagstack C-t jump back
  vim.keymap.set('n', 'gD', '<cmd>Lspsaga peek_definition<CR>', defaults)

  -- Show line diagnostics
  -- vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", defaults)

  -- Show cursor diagnostic
  vim.keymap.set('n', 'ge', '<cmd>Lspsaga show_cursor_diagnostics<CR>', defaults)

  -- Diagnsotic jump can use `<c-o>` to jump back
  vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', defaults)
  vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', defaults)

  -- Only jump to error
  local goto_opts = { severity = vim.diagnostic.severity.ERROR }
  local goto_prev = function()
    require('lspsaga.diagnostic').goto_prev(goto_opts)
  end
  local goto_next = function()
    require('lspsaga.diagnostic').goto_next(goto_opts)
  end
  vim.keymap.set('n', '[E', goto_prev, defaults)
  vim.keymap.set('n', ']E', goto_next, defaults)

  -- Outline
  vim.keymap.set('n', 'go', '<cmd>LSoutlineToggle<CR>', defaults)

  -- Hover Doc
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', defaults)

  -- -- Float terminal
  -- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", defaults)
  -- -- if you want pass somc cli command into terminal you can do like this
  -- -- open lazygit in lspsaga float terminal
  -- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", defaults)
  -- -- close floaterm
  -- vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], defaults)
end

return M
