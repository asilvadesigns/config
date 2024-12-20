local has_navic = package.loaded["nvim-navic"] ~= nil

local function get_location()
  if not has_navic then
    return ""
  end

  local ok, navic = pcall(require, "nvim-navic")
  if not ok then
    return ""
  end

  -- Only show location if navic is attached to current buffer
  if not navic.is_available() then
    return ""
  end

  return navic.get_location()
end

_G.statusline_timer = nil

local function start_statusline_polling()
  -- Clear existing timer if it exists
  if _G.statusline_timer then
    _G.statusline_timer:stop()
    _G.statusline_timer:close()
  end

  -- Create new timer
  _G.statusline_timer = vim.uv.new_timer()

  -- Start the timer with 250ms interval
  _G.statusline_timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      local buf_id = vim.api.nvim_get_current_buf()

      local bufname = vim.api.nvim_buf_get_name(buf_id)
      local filename = vim.fn.fnamemodify(bufname, ":t")
      local filepath = vim.fn.fnamemodify(bufname, ":~:h")
      local filetype = vim.bo[buf_id].filetype

      -- local location = get_location()
      -- local context = vim.api.nvim_eval("nvim_treesitter#statusline(90)")

      local value = "%*%#NonText#" .. filepath .. "/" .. "%*%#Normal#" .. filename .. "%*"
      local location = "%{%v:lua.require'nvim-navic'.get_location()%}"

      vim.opt.statusline = table.concat({
        location,
      }, "")
    end)
  )
end

start_statusline_polling()

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if _G.statusline_timer then
      _G.statusline_timer:stop()
      _G.statusline_timer:close()
    end
  end,
})
