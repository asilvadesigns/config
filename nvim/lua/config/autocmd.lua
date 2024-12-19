-- NOTE: modes.nvim is handling this
-- -- highlight on yank
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

-- go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- local visual_event_group = vim.api.nvim_create_augroup("visual_event", { clear = true })
--
-- vim.api.nvim_create_autocmd("ModeChanged", {
--   group = visual_event_group,
--   pattern = { "*:[vV\x16]*" },
--   callback = function()
--     print("VisualEnter")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("ModeChanged", {
--   group = visual_event_group,
--   pattern = { "[vV\x16]*:*" },
--   callback = function()
--     print("VisualLeave")
--   end,
-- })

-- show numbers in help
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "help",
--   command = "setlocal number relativenumber",
-- })

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- restore cursor
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
vim.api.nvim_create_augroup("auto_read", { clear = true })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({
  "FocusGained",
  "TermClose",
  "TermLeave",
}, { command = "checktime" })

vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

local DeferGroup = vim.api.nvim_create_augroup("DeferGroup", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "DeferOne",
  group = DeferGroup,
  callback = function() end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "DeferTwo",
  group = DeferGroup,
  callback = function() end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "DeferThree",
  group = DeferGroup,
  callback = function() end,
})

-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--   callback = function()
--     vim.wo.winhighlight = "CursorLineNr:CursorLineNrActive"
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
--   callback = function()
--     vim.wo.winhighlight = "CursorLineNr:CursorLineNr"
--   end,
-- })
--
-- vim.api.nvim_set_hl(0, "CursorLineNrActive", { fg = "Yellow", bold = true })
