-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- local cursorline_include_filetypes = {
--   "NvimTree",
-- }
--
-- show cursorline for certain filetypes
-- vim.api.nvim_create_autocmd("WinEnter", {
--   callback = function()
--     if vim.tbl_contains(cursorline_include_filetypes, vim.bo.filetype) then
--       vim.cmd("setlocal cursorline")
--     else
--       vim.cmd("setlocal nocursorline")
--     end
--   end,
-- })

-- show numbers in help
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "setlocal number relativenumber",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

--
-- local function renderWinbar()
--   local win_config = vim.api.nvim_win_get_config(0)
--   local win_filetype = vim.bo.filetype
--
--   if win_config.relative ~= "" or win_filetype == "telescope" then
--     return ""
--   end
--
--   if vim.tbl_contains(winbar_exclude_filetypes, win_filetype) then
--     vim.opt_local.winbar = nil
--     return ""
--   end
--
--   local sep = "  "
--   local name = vim.fn.expand("%:t")
--   local path = " " .. string.gsub(vim.fn.expand("%:~:.:h"), "/", sep) .. sep
--
--   local buf = vim.api.nvim_get_current_buf()
--   local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
--
--   local flag = buf_modified and " +" or "  "
--
--   return "%#CursorLineFold#" .. path .. name .. flag .. "%*"
-- end

-- local function lsp()
--   local count = {
--     Error = 0,
--     Hint = 0,
--     Info = 0,
--     Warn = 0,
--   }
--
--   local signs = {
--     Error = "󰅚 ",
--     Hint = "󰌶 ",
--     Info = " ",
--     Warn = "󰀪 ",
--   }
--
--   local levels = {
--     errors = "Error",
--     hints = "Hint",
--     info = "Info",
--     warnings = "Warn",
--   }
--
--   for _, level in pairs(levels) do
--     count[level] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
--   end
--
--   local errors = signs["Error"] .. count["Error"] .. " "
--   local hints = signs["Hint"] .. count["Hint"] .. " "
--   local info = signs["Info"] .. count["Info"] .. " "
--   local warnings = signs["Warn"] .. count["Warn"] .. " "
--
--   return errors .. warnings .. hints .. info
-- end

local cached_git_value = ""

local function renderStatusLine()
  local git_info = vim.api.nvim_eval_statusline("%{FugitiveStatusline()}", {})
  local git_info_str = git_info["str"]

  if git_info_str ~= "" then
    cached_git_value = "  " .. string.match(git_info_str, "%((.-)%)")
  end

  return "%#CursorLineFold#" .. cached_git_value
end

local render_winbar_group = "winbar_update"
local render_winbar_time = 100
local render_winbar_timer = vim.fn.timer_start(render_winbar_time, function() end)

vim.api.nvim_create_augroup(render_winbar_group, { clear = true })

vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufModifiedSet",
  "BufNewFile",
  "BufReadPre",
  "BufWritePost",
  "CursorHold",
  "TextChanged",
  "TextChangedI",
}, {
  group = render_winbar_group,
  callback = function()
    if render_winbar_timer ~= nil and vim.fn.timer_stop(render_winbar_timer) ~= -1 then
      render_winbar_timer = nil
    end

    render_winbar_timer = vim.fn.timer_start(render_winbar_time, function()
      vim.opt.statusline = renderStatusLine()
    end)
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
