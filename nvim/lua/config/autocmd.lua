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

local cached_git_label = " ..loading"
local cached_statusline_value = " "
local cached_winbar_value = {}
local render_winbar_timer = vim.loop.new_timer()
local WINBAR_COLOR = "%#WinBar#"
local STATUS_COLOR = "%#StatusLine#"

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
    local buf_filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_id })

    if vim.tbl_contains(winbar_exclude_filetypes, buf_filetype) then
      goto continue
    end

    local buf_name = vim.api.nvim_buf_get_name(buf_id)

    local filename = vim.fn.fnamemodify(buf_name, ":t")
    local filepath = " " .. vim.fn.fnamemodify(buf_name, ":~:.:h") .. "/" .. filename
    -- local sep = "  "
    -- local filepath = " " .. string.gsub(vim.fn.fnamemodify(buf_name, ":~:.:h"), "/", sep) .. sep

    local modified = "%#Comment# 󰆓 %*"
    if vim.bo[buf_id].modified == true then
      modified = "%#DiagnosticSignWarn# 󰆓 %*"
    end

    local diagnostics = GetDiagnostics(buf_id)
    local next_winbar = WINBAR_COLOR .. filepath .. modified .. "%*" .. " " .. diagnostics

    vim.api.nvim_set_option_value("winbar", next_winbar, { win = win_id })
    ::continue::
  end
end

-- local function renderStatusLine()
--   -- get filename
--   local buf_name = vim.api.nvim_buf_get_name(0)
--   local sep = "/"
--   local f_name = vim.fn.fnamemodify(buf_name, ":t")
--   local f_path = string.gsub(vim.fn.fnamemodify(buf_name, ":~:.:h"), "/", sep) .. sep
--   local f_label = f_path .. f_name
--
--   -- -- get diagnostics
--   -- local d_label = ""
--   -- local d_count = vim.diagnostic.count(0)
--   -- local square = vim.fn.nr2char(0x25aa)
--   --
--   -- if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
--   --   d_label = d_label .. " %#DiagnosticSignError#" .. square .. d_count[vim.diagnostic.severity.ERROR] .. "%*"
--   -- end
--   -- if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
--   --   d_label = d_label .. " %#DiagnosticSignHint#" .. square .. d_count[vim.diagnostic.severity.HINT] .. "%*"
--   -- end
--   -- if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
--   --   d_label = d_label .. " %#DiagnosticSignInfo#" .. square .. d_count[vim.diagnostic.severity.INFO] .. "%*"
--   -- end
--   -- if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
--   --   d_label = d_label .. " %#DiagnosticSignWarn#" .. square .. d_count[vim.diagnostic.severity.WARN] .. "%*"
--   -- end
--
--   -- local lazy_ready, lazy_config = pcall(require, "lazy.core.config")
--
--   -- local tmux_label = ""
--   -- local tmux_panes = ""
--   -- if vim.env.TMUX ~= nil then
--   --   tmux_panes = GetTmuxPaneCount()
--   --   tmux_label = "%#DiagnosticSignHint#" .. "" .. " " .. tmux_panes .. "%*"
--   -- end
--
--   vim.opt.statusline = STATUS_COLOR .. " " .. f_label .. "%*"
--
--   -- if lazy_ready then
--   --   if lazy_config.plugins["vim-tpipeline"]._.loaded then
--   --     vim.cmd("silent! call tpipeline#update()")
--   --   end
--   -- end
-- end

vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufModifiedSet",
  "DiagnosticChanged",
}, {
  group = vim.api.nvim_create_augroup("render_ui", { clear = true }),
  callback = function()
    -- renderStatusLine()
    renderWinbar()
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
