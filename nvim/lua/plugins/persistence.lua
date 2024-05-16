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
  "folke/persistence.nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("persistence").setup({
      pre_save = function()
        delete_all_buffers_except_current()
        vim.cmd("only")
      end,
    })

    if next(vim.fn.argv()) == nil then
      require("persistence").load()
    end

    vim.api.nvim_create_autocmd("ExitPre", {
      callback = function()
        require("persistence").save()
      end,
    })

    vim.api.nvim_create_user_command("LoadSession", function()
      require("persistence").load()
    end, {})

    vim.api.nvim_create_user_command("SaveSession", function()
      require("persistence").save()
    end, {})
  end,
}
