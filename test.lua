-- print('yo...')
-- local buffers = vim.api.nvim_list_bufs()
--
-- for _, bufnr in ipairs(buffers) do
--   if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) ~= '' then
--     print('\ngot em::' .. bufnr)
--     print('info::', vim.api.nvim_buf_get_name(bufnr))
--     vim.wo[bufnr].winbar = "looking like... " .. bufnr
--   end
-- end

local function getVisibleWindows()
  local windows = vim.api.nvim_list_wins()
  for _, win_id in ipairs(windows) do
    local is_floating = vim.api.nvim_win_get_config(win_id).relative
    local is_empty = vim.api.nvim_win_get_buf(win_id) < 1

    if is_floating or is_empty then
      goto continue
    end

    vim.api.nvim_win_set_option(win_id, 'winbar', 'updated!')
    ::continue::
  end
end
