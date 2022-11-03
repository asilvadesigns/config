local M = {}

local state = {
  last_buf = '',
}

local tools = {
  NvimTree = true,
  Trouble = true,
  ctrlsf = true,
  qf = true,
}

local get_focus = function()
  if (tools[vim.bo.filetype]) then
    vim.cmd("execute bufwinnr(" .. state.last_buf .. ") 'wincmd w'")
  end
end

local set_focus = function()
  if (not tools[vim.bo.filetype]) then
    state.last_buf = vim.api.nvim_exec('echo bufnr()', true)
  end
end

M.setup = function()
  local saveGroup = vim.api.nvim_create_augroup('saveDocs', { clear = true })

  -- enable save previous buffer
  vim.api.nvim_create_autocmd(
    { 'BufLeave' },
    {
      pattern = '*',
      callback = set_focus,
      group = saveGroup
    }
  )

  -- return focus to previous buffer
  vim.keymap.set('n', '<esc>', get_focus)
end

return M
