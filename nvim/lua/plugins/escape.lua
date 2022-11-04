local switch = function(element)
  local Table = {
    ["Value"] = element,
    ["DefaultFunction"] = nil,
    ["Functions"] = {}
  }

  Table.case = function(testElement, callback)
    Table.Functions[testElement] = callback
    return Table
  end

  Table.default = function(callback)
    Table.DefaultFunction = callback
    return Table
  end

  Table.process = function()
    local Case = Table.Functions[Table.Value]
    if Case then
      Case()
    elseif Table.DefaultFunction then
      Table.DefaultFunction()
    end
  end

  return Table
end

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

local restore = function()
  vim.cmd("execute bufwinnr(" .. state.last_buf .. ") 'wincmd w'")
end

M.get_focus = function()
  switch(vim.bo.filetype)
      .case('NvimTree', restore)
      .case('neo-tree', restore)
      .default(function()end)
      .process()

  if (tools[vim.bo.filetype]) then
    vim.cmd("execute bufwinnr(" .. state.last_buf .. ") 'wincmd w'")
  end
end

M.set_focus = function()
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
      callback = M.set_focus,
      group = saveGroup
    }
  )

  -- return focus to previous buffer
  vim.keymap.set('n', '<ESC>', M.get_focus)
end

return M
