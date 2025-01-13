--- NOTE: when enabled, we show a full global status with diagnostics
--- NOTE: when disabled, we hide any statusline
_G.statusline_enabled = false
if _G.statusline_enabled then
  vim.opt.statusline = ""
end

--- NOTE: when enabled, we show a full winbar per window with diagnostics
--- NOTE: when disabled, we show the filename with incline with diagnostics
_G.winbar_enabled = true
if _G.winbar_enabled then
  vim.opt.winbar = ""
end

---@param buf_id integer
---@param highlight boolean
---@return string
local function get_diagnostics(buf_id, highlight)
  local d_count = vim.diagnostic.count(buf_id)
  local d_label = ""
  local square = vim.fn.nr2char(0x25aa)

  if highlight then
    if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
      d_label = d_label .. " %#DiagnosticSignError#" .. square .. d_count[vim.diagnostic.severity.ERROR] .. "%*"
    end
    if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
      d_label = d_label .. " %#DiagnosticSignHint#" .. square .. d_count[vim.diagnostic.severity.HINT] .. "%*"
    end
    if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
      d_label = d_label .. " %#DiagnosticSignInfo#" .. square .. d_count[vim.diagnostic.severity.INFO] .. "%*"
    end
    if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
      d_label = d_label .. " %#DiagnosticSignWarn#" .. square .. d_count[vim.diagnostic.severity.WARN] .. "%*"
    end
  else
    if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
      d_label = d_label .. " %#WDiagnosticSignError#" .. square .. d_count[vim.diagnostic.severity.ERROR] .. "%*"
    end
    if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
      d_label = d_label .. " %#WDiagnosticSignHint#" .. square .. d_count[vim.diagnostic.severity.HINT] .. "%*"
    end
    if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
      d_label = d_label .. " %#WDiagnosticSignInfo#" .. square .. d_count[vim.diagnostic.severity.INFO] .. "%*"
    end
    if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
      d_label = d_label .. " %#WDiagnosticSignWarn#" .. square .. d_count[vim.diagnostic.severity.WARN] .. "%*"
    end
  end

  return d_label
end

---@param buf_id integer
---@return string
local function get_modified(buf_id)
  local is_modified = vim.api.nvim_get_option_value("modified", { buf = buf_id })

  if is_modified then
    return "+"
  end

  return ""
end

---@param buf_id integer
---@param highlight boolean
---@return string
local function get_filename(buf_id, highlight)
  local bufname = vim.api.nvim_buf_get_name(buf_id)
  local filename = vim.fn.fnamemodify(bufname, ":t")
  local filepath = vim.fn.fnamemodify(bufname, ":~:h")
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_id })

  if filetype == "oil" then
    return vim.fn.expand("%:~:h")
  end

  if filename == "" then
    return ""
  end

  if highlight then
    return "%*%#NonText#" .. filepath .. "/" .. "%*%#Normal#" .. filename .. "%*"
  end

  return filepath .. "/" .. filename
end

local function enable_winbar(win_id)
  local buf_id = vim.api.nvim_win_get_buf(win_id)
  local win_config = vim.api.nvim_win_get_config(win_id)

  local filetype = vim.bo[buf_id].filetype
  local is_floating = win_config.relative ~= ""

  if is_floating or filetype == "NvimTree" or filetype == "toggleterm" or filetype == "snacks_dashboard" then
    vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
  else
    local new_winbar = " "
      .. get_filename(buf_id, true)
      .. " "
      .. get_modified(buf_id)
      .. " "
      .. get_diagnostics(buf_id, true)
      .. "%*%#NonText# %=%l/%L %*"

    vim.api.nvim_set_option_value("winbar", new_winbar, { win = win_id })
  end
end

local function disable_winbar(win_id)
  vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
end

local function enable_statusline(win_id)
  vim.opt.laststatus = 3
  local buf_id = vim.api.nvim_win_get_buf(win_id)

  -- stylua: ignore start
  local new_statusline = " "
    .. get_filename(buf_id, false)
    .. " "
    .. get_diagnostics(buf_id, false)
    .. "%=%l/%L"
    .. " "
  -- stylua: ignore end

  vim.api.nvim_set_option_value("statusline", new_statusline, { win = win_id })
end

local function disable_statusline(win_id)
  vim.opt.laststatus = 0
  vim.opt.statusline = string.rep("—", vim.api.nvim_win_get_width(win_id))
end

local function render_statusline()
  vim.schedule(function()
    if _G.statusline_enabled then
      enable_statusline(0)
    else
      disable_statusline(0)
    end
  end)
end

local function render_winbar()
  vim.schedule(function()
    local status_ok, incline = pcall(require, "incline")
    if _G.winbar_enabled then
      if status_ok then
        incline.disable()
      end
    else
      if status_ok then
        incline.enable()
      end
    end

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if _G.winbar_enabled then
        enable_winbar(win)
      else
        disable_winbar(win)
      end
    end
  end)
end

local RenderGroup = vim.api.nvim_create_augroup("update_group", { clear = true })

--- Create Statusline autocmd and command
vim.api.nvim_create_autocmd("User", {
  pattern = "RefreshStatusline",
  group = RenderGroup,
  callback = function() end,
})

vim.api.nvim_create_user_command("ToggleStatusline", function()
  _G.statusline_enabled = not _G.statusline_enabled
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshStatusline" })
end, {})

--- Create Winbar autocmd and command
vim.api.nvim_create_autocmd("User", {
  pattern = "RefreshWinbar",
  group = RenderGroup,
  callback = function() end,
})

vim.api.nvim_create_user_command("ToggleWinbar", function()
  _G.winbar_enabled = not _G.winbar_enabled
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshWinbar" })
end, {})

--- Render Statusline and Winbar on autocmds...
vim.api.nvim_create_autocmd({ "BufModifiedSet", "BufNewFile", "BufReadPre", "DiagnosticChanged", "TabClosed" }, {
  group = RenderGroup,
  callback = function()
    render_statusline()
    render_winbar()
  end,
})

--- Render Statusline on vim.cmd("RefreshStatusline")
vim.api.nvim_create_autocmd({ "User" }, {
  group = RenderGroup,
  pattern = "RefreshStatusline",
  callback = render_statusline,
})

--- Render Winbar on vim.cmd("RefreshWinbar")
vim.api.nvim_create_autocmd({ "User" }, {
  group = RenderGroup,
  pattern = "RefreshWinbar",
  callback = render_winbar,
})
