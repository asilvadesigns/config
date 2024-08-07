---@param buf_id number
function GetDiagnostics(buf_id)
  local d_label = ""
  local d_count = vim.diagnostic.count(buf_id)
  local square = vim.fn.nr2char(0x25aa)

  if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
    d_label = d_label .. "%#DiagnosticSignError#" .. square .. d_count[vim.diagnostic.severity.ERROR] .. "%*"
  end
  if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
    d_label = d_label .. "%#DiagnosticSignHint#" .. square .. d_count[vim.diagnostic.severity.HINT] .. "%*"
  end
  if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
    d_label = d_label .. "%#DiagnosticSignInfo#" .. square .. d_count[vim.diagnostic.severity.INFO] .. "%*"
  end
  if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
    d_label = d_label .. "%#DiagnosticSignWarn#" .. square .. d_count[vim.diagnostic.severity.WARN] .. "%*"
  end

  return d_label
end

function GetTmuxPaneCount()
  -- Run the command and capture the output
  local handle = io.popen("tmux list-panes | wc -l")
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    -- Trim any whitespace from the output
    result = result:gsub("%s+", "")
    return result
  end

  return ""
end

--
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

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

-- restore cursor
-- vim.api.nvim_create_autocmd("BufRead", {
--   callback = function(opts)
--     vim.api.nvim_create_autocmd("BufWinEnter", {
--       once = true,
--       buffer = opts.buf,
--       callback = function()
--         local ft = vim.bo[opts.buf].filetype
--         local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
--         if
--           not (ft:match("commit") and ft:match("rebase"))
--           and last_known_line > 1
--           and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
--         then
--           vim.api.nvim_feedkeys([[g`"]], "nx", false)
--         end
--       end,
--     })
--   end,
-- })

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
local LARGE_BUFFER = 2000000

local function detect_large_buffer(buffer)
  buffer = buffer or vim.api.nvim_get_current_buf()
  local stats_ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buffer))
  if stats_ok and stats and (stats.size > LARGE_BUFFER) then
    return true
  end
  return false
end

--- NOTE: shamelessly take from: https://github.com/lettertwo/config/blob/fe866b91d44dfac850fb9fa030b838ce8c89789a/nvim/lua/config/autocmds.lua#L96
local LARGE_BUFFER_DISABLED = {
  cmp = function()
    require("cmp").setup.buffer({ enabled = false })
  end, ---@diagnostic disable-line: missing-fields
  colorizer = "ColorizerDetachFromBuffer",
  folds = function()
    vim.opt_local.foldmethod = "manual"
  end,
  illuminate = function()
    require("illuminate").pause_buf()
  end,
  indent_blankline = "IBLDisable",
  spell = function()
    vim.opt_local.spell = false
  end,
  syntax = "syntax off",
  treesitter_context = "TSContextDisable",
  treesitter_highlight = "TSBufDisable highlight",
  ufo = function()
    require("ufo").detach()
  end,
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
