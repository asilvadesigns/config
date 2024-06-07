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

-- local cached_git_value = "  ..loading"
local cached_statusline_value = " "
-- local cached_winbar_value = {}
-- local render_winbar_timer = vim.loop.new_timer()
-- local WINBAR_COLOR = "%#Comment#"
-- local STATUS_COLOR = "%#NonText#"

---@return table<string>
-- local function getVisibleWindows()
--   local visible_buffers = {}
--   local windows = vim.api.nvim_list_wins()
--
--   for _, win_id in ipairs(windows) do
--     local is_floating = vim.api.nvim_win_get_config(win_id).relative ~= ""
--     local is_empty = vim.api.nvim_win_get_buf(win_id) < 1
--
--     if is_floating or is_empty then
--       goto continue
--     end
--
--     table.insert(visible_buffers, win_id)
--     ::continue::
--   end
--
--   return visible_buffers
-- end

-- local winbar_exclude_filetypes = {
--   "NvimTree",
--   "Outline",
--   "TelescopePrompt",
--   "Trouble",
--   "alpha",
--   "dashboard",
--   "help",
--   "lir",
--   "neogitstatus",
--   "no-neck-pain",
--   "packer",
--   "spectre_panel",
--   "startify",
--   "telescope",
--   "toggleterm",
--   -- "qf",
-- }

-- local function renderWinbar()
--   local windows = getVisibleWindows()
--
--   for _, win_id in ipairs(windows) do
--     local buf = vim.api.nvim_win_get_buf(win_id)
--     local buf_filetype = vim.api.nvim_get_option_value("filetype", { buf })
--
--     if vim.tbl_contains(winbar_exclude_filetypes, buf_filetype) then
--       goto continue
--     end
--
--     local buf_name = vim.api.nvim_buf_get_name(buf)
--
--     local sep = "  "
--     local filename = vim.fn.fnamemodify(buf_name, ":t")
--     local filepath = " " .. string.gsub(vim.fn.fnamemodify(buf_name, ":~:.:h"), "/", sep) .. sep
--
--     -- local is_modified = vim.bo[buf].modified
--     -- local flag = is_modified and " +" or "  "
--
--     local next_winbar = WINBAR_COLOR .. filepath .. filename .. "%*"
--
--     if cached_winbar_value[buf] ~= next_winbar then
--       cached_winbar_value[buf] = next_winbar
--       vim.api.nvim_set_option_value(win_id, "winbar", cached_winbar_value[buf])
--     end
--     ::continue::
--   end
-- end

local function renderStatusLine()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local sep = "/"
  local filename = vim.fn.fnamemodify(buf_name, ":t")
  local filepath = string.gsub(vim.fn.fnamemodify(buf_name, ":~:.:h"), "/", sep) .. sep

  local diagnostic_label = ""
  local diagnostic_count = vim.diagnostic.count(0)
  local square = vim.fn.nr2char(0x25aa)

  if diagnostic_count[vim.diagnostic.severity.ERROR] and diagnostic_count[vim.diagnostic.severity.ERROR] > 0 then
    diagnostic_label = diagnostic_label .. " %#DiagnosticSignError#" .. square .. diagnostic_count[vim.diagnostic.severity.ERROR] .. "%*"
  end
  if diagnostic_count[vim.diagnostic.severity.HINT] and diagnostic_count[vim.diagnostic.severity.HINT] > 0 then
    diagnostic_label = diagnostic_label .. " %#DiagnosticSignHint#" .. square .. diagnostic_count[vim.diagnostic.severity.HINT] .. "%*"
  end
  if diagnostic_count[vim.diagnostic.severity.INFO] and diagnostic_count[vim.diagnostic.severity.INFO] > 0 then
    diagnostic_label = diagnostic_label .. " %#DiagnosticSignInfo#" .. square .. diagnostic_count[vim.diagnostic.severity.INFO] .. "%*"
  end
  if diagnostic_count[vim.diagnostic.severity.WARN] and diagnostic_count[vim.diagnostic.severity.WARN] > 0 then
    diagnostic_label = diagnostic_label .. " %#DiagnosticSignWarn#" .. square .. diagnostic_count[vim.diagnostic.severity.WARN] .. "%*"
  end

  -- local next_statusline = STATUS_COLOR .. "  " .. filepath .. filename .. "%*" .. diagnostic_label
  local next_statusline = "  " .. filepath .. filename .. "%*" .. diagnostic_label

  if cached_statusline_value ~= next_statusline then
    cached_statusline_value = next_statusline
    vim.opt.statusline = cached_statusline_value
  end
end

vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufModifiedSet",
  "DiagnosticChanged",
}, {
  group = vim.api.nvim_create_augroup("render_ui", { clear = true }),
  callback = function()
    renderStatusLine()
    -- renderWinbar()
  end,
})
--
-- render_winbar_timer:start(
--   0,
--   500,
--   vim.schedule_wrap(function()
--     -- renderStatusLine()
--     renderWinbar()
--   end)
-- )

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
