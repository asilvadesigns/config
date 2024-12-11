local M = {}

local function close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

M.setup = function()
  require("auto-session").setup({
    session_lens = {
      load_on_setup = false,
    },
    pre_save_cmds = {
      close_all_floating_win,
    },
    post_restore_cmds = {
      function()
        vim.opt.cmdheight = 0
      end,
    },
  })
end

return M
