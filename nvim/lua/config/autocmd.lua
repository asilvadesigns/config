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
local cached_statusline_value = " "
local cached_winbar_value = " "
local UI_COLOR = "%#CursorLineFold#"
local render_winbar_timer = vim.loop.new_timer()

---@return table<string>
local function getVisibleWindows()
  local visible_buffers = {}
  local windows = vim.api.nvim_list_wins()

  for _, win_id in ipairs(windows) do
    local is_floating = vim.api.nvim_win_get_config(win_id).relative ~= ""
    local is_empty = vim.api.nvim_win_get_buf(win_id) < 1

    if is_floating or is_empty then
      goto continue
    end

    table.insert(visible_buffers, win_id)
    ::continue::
  end

  return visible_buffers
end

local winbar_exclude_filetypes = {
  "NvimTree",
  "Outline",
  "TelescopePrompt",
  "Trouble",
  "alpha",
  "dashboard",
  "help",
  "lir",
  "neogitstatus",
  "no-neck-pain",
  "packer",
  "spectre_panel",
  "startify",
  "telescope",
  "toggleterm",
  -- "qf",
}

local function renderWinbar()
  local windows = getVisibleWindows()

  for _, win_id in ipairs(windows) do
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local buf_filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")

    if vim.tbl_contains(winbar_exclude_filetypes, buf_filetype) then
      goto continue
    end

    local buf_name = vim.api.nvim_buf_get_name(buf_id)

    local sep = "  "
    local filename = vim.fn.fnamemodify(buf_name, ":t")
    local filepath = " " .. string.gsub(vim.fn.fnamemodify(buf_name, ":~:.:h"), "/", sep) .. sep

    local is_modified = vim.bo[buf_id].modified
    local flag = is_modified and " +" or "  "

    local next_winbar = UI_COLOR .. filepath .. filename .. flag .. "%*"

    vim.api.nvim_win_set_option(win_id, "winbar", next_winbar)
    ::continue::
  end
end

local function renderStatusLine()
  local lazy_ready, lazy_config = pcall(require, "lazy.core.config")
  if not lazy_ready then
    vim.opt.statusline = UI_COLOR .. cached_git_value
    return
  end

  local fugitive_ready = lazy_config.plugins["vim-fugitive"]._.loaded
  if not fugitive_ready then
    vim.opt.statusline = UI_COLOR .. cached_git_value
    return
  end

  local git_info = vim.api.nvim_eval_statusline("%{FugitiveStatusline()}", {})
  local git_info_str = git_info["str"]

  if git_info_str ~= "" then
    cached_git_value = "  " .. string.match(git_info_str, "%((.-)%)")
  end

  local next_statusline = UI_COLOR .. cached_git_value

  if cached_statusline_value ~= next_statusline then
    cached_statusline_value = next_statusline
    vim.opt.statusline = cached_statusline_value
  end
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = vim.api.nvim_create_augroup("render_ui", { clear = true }),
  callback = function()
    renderStatusLine()
    renderWinbar()
  end,
})

render_winbar_timer:start(
  0,
  500,
  vim.schedule_wrap(function()
    renderStatusLine()
    renderWinbar()
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
