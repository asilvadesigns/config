-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

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
--

local cached_git_value = "  ..loading"
local cached_winbar_value = " "
local render_winbar_timer = vim.loop.new_timer()

local function renderStatusLine()
  local lazy_ready, lazy_config = pcall(require, "lazy.core.config")
  if not lazy_ready then
    return "%#CursorLineFold#" .. cached_git_value
  end

  local fugitive_ready = lazy_config.plugins["vim-fugitive"]._.loaded
  if not fugitive_ready then
    return "%#CursorLineFold#" .. cached_git_value
  end

  local git_info = vim.api.nvim_eval_statusline("%{FugitiveStatusline()}", {})
  local git_info_str = git_info["str"]

  if git_info_str ~= "" then
    cached_git_value = "  " .. string.match(git_info_str, "%((.-)%)")
  end

  return "%#CursorLineFold#" .. cached_git_value
end

render_winbar_timer:start(
  0,
  250,
  vim.schedule_wrap(function()
    local next_winbar = renderStatusLine()
    if cached_winbar_value ~= next_winbar then
      cached_winbar_value = next_winbar
      vim.opt.statusline = cached_winbar_value
    end
  end)
)

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

-- Disable some sources of slowdown in large buffers.
local LARGE_BUFFER = 1000000

local function detect_large_buffer(buffer)
  buffer = buffer or vim.api.nvim_get_current_buf()
  local stats_ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
  if stats_ok and stats and (stats.size > LARGE_BUFFER) then
    return true
  end
  return false
end

-- stylua: ignore start
local LARGE_BUFFER_DISABLED = {
  cmp = function() require("cmp").setup.buffer({ enabled = false }) end, ---@diagnostic disable-line: missing-fields
  colorizer = "ColorizerDetachFromBuffer",
  folds = function() vim.opt_local.foldmethod = "manual" end,
  illuminate = function() require("illuminate").pause_buf() end,
  indent_blankline = "IBLDisable",
  spell = function() vim.opt_local.spell = false end,
  syntax = "syntax off",
  treesitter_context = "TSContextDisable",
  treesitter_highlight = "TSBufDisable highlight",
  ufo = function() require("ufo").detach() end,
}
-- stylua: ignore end

local function disable_large_buffer(buffer)
  buffer = buffer or vim.api.nvim_get_current_buf()

  if vim.api.nvim_buf_get_var(buffer, "large_buffer") then
    return
  end

  vim.api.nvim_buf_set_var(buffer, "large_buffer", true)

  local disabled = {}
  for path, cmd in pairs(LARGE_BUFFER_DISABLED) do
    if type(cmd) == "function" then
      local ok = pcall(cmd)
      if ok then
        vim.notify(path .. " disabled", vim.log.levels.DEBUG)
        table.insert(disabled, path)
      else
        vim.notify("Failed to disable " .. path, vim.log.levels.ERROR)
      end
    elseif pcall(vim.cmd, cmd) then ---@diagnostic disable-line: param-type-mismatch
      vim.notify(path .. " disabled with " .. cmd, vim.log.levels.DEBUG)
      table.insert(disabled, path)
    else
      vim.notify(cmd .. " failed", vim.log.levels.ERROR)
    end
  end
  vim.notify("Disabling:\n  " .. table.concat(disabled, "\n  "), vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("DisableLargeBuffer", function()
  disable_large_buffer()
end, {})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("large_buffer", { clear = true }),
  callback = function()
    local buffer = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_var(buffer, "large_buffer", false)
    if detect_large_buffer(buffer) then
      vim.notify("Large file detected!", vim.log.levels.INFO)
      disable_large_buffer(buffer)
    end
  end,
})
