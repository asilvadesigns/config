local delete_all_buffers_except_current = function()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end

return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local handle_pre_save = function()
      delete_all_buffers_except_current()
      require("no-neck-pain").disable()
      vim.cmd("NvimTreeClose")
    end

    require("auto-session").setup({
      log_level = "error",
      pre_save_cmds = { handle_pre_save },
      session_lens = {
        load_on_setup = false,
      },
    })
  end,
}
