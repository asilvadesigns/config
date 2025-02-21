local M = {}

M.setup = function()
  require("auto-session").setup({
    auto_restore = false,
    session_lens = {
      load_on_setup = false,
    },
    log_level = vim.log.levels.ERROR,
    pre_save_cmds = {
      function()
        for _, win_id in ipairs(vim.api.nvim_list_wins()) do
          local win_config = vim.api.nvim_win_get_config(win_id)
          local buf_id = vim.api.nvim_win_get_buf(win_id)

          --- NOTE: close all floating windows
          if win_config.relative ~= "" then
            vim.api.nvim_win_close(win_id, false)
          end

          --- NOTE: close all search windows
          if vim.bo[buf_id].filetype == "grug-far" then
            vim.api.nvim_win_close(win_id, false)
          end
        end
      end,
    },
    post_restore_cmds = {
      function()
        vim.opt.cmdheight = 0
      end,
    },
  })

  -- vim.keymap.set("n", "<leader>s", "<CMD>SessionSearch<CR>", { desc = "Fuzzy files" })
end

return M
