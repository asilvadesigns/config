if _G.hide_all then
  _G.show_statusline = false
  _G.show_winbar = false
else
  if _G.show_statusline then
    vim.opt.statusline = ""
  else
    vim.opt.laststatus = 0
    vim.opt.statusline = "%{repeat('─', winwidth('.'))}"
  end

  if _G.show_winbar then
    vim.opt.winbar = ""
  else
    vim.opt.winbar = nil
  end
end

--- @type table<integer, string>
local statusline_cache = {}

--- @type table<string, boolean>
local excluded_filetypes = {
  ["NeogitStatus"] = true,
  ["NvimTree"] = true,
  ["grug-far"] = true,
  ["help"] = true,
  ["neo-tree"] = true,
  ["no-neck-pain"] = true,
  -- ["oil"] = true,
  ["qf"] = true,
  ["snacks_dashboard"] = true,
  ["spectre_panel"] = true,
  ["toggleterm"] = true,
}

local severity = vim.diagnostic.severity
local severity_order = { severity.ERROR, severity.WARN, severity.INFO, severity.HINT }
local severity_hl = {
  [severity.ERROR] = "DiagnosticSignError",
  [severity.HINT] = "DiagnosticSignHint",
  [severity.INFO] = "DiagnosticSignInfo",
  [severity.WARN] = "DiagnosticSignWarn",
}
local severity_icon = {
  [severity.ERROR] = " ", --signs.icons.square,
  [severity.HINT] = " ", --signs.icons.square,
  [severity.INFO] = " ", --signs.icons.square,
  [severity.WARN] = " ", --signs.icons.square,
}

---@param buf_id integer | nil
---@return string
local function get_diagnostics(buf_id)
  local d_count = vim.diagnostic.count(buf_id)
  local d_parts = {}

  for _, sev in ipairs(severity_order) do
    local count = d_count[sev]
    if count and count > 0 then
      -- table.insert(d_parts, string.format(" %%#%s#%s %d%%*", severity_hl[sev], severity_icon[sev], count))
      table.insert(d_parts, string.format("%%#%s#%s %d%%*", severity_hl[sev], severity_icon[sev], count))
    end
  end

  return table.concat(d_parts)
end

---@param buf_id integer
---@param is_winbar boolean
---@return string
local function get_modified(buf_id, is_winbar)
  if vim.api.nvim_get_option_value("modified", { buf = buf_id }) then
    if is_winbar then
      return "%#Normal#󰈸%*"
    end
    return "󰈸"
  else
    return " "
  end
end

---@param buf_id integer
---@param is_winbar boolean
---@return string
local function get_filename(buf_id, is_winbar)
  local cwd = vim.fn.getcwd()
  if cwd:sub(-1) ~= "/" then
    cwd = cwd .. "/"
  end

  local filepath = vim.api.nvim_buf_get_name(buf_id)
  local filetype = vim.bo[buf_id].filetype

  if filetype == "oil" then
    return vim.fn.expand("%:~:h"):sub(#cwd)
  end

  if filetype == "trouble" then
    return "Diagnostics"
  end

  local filename = vim.fn.fnamemodify(filepath, ":t")
  if filename == "" then
    return ""
  end

  if filepath:sub(1, #cwd) == cwd then
    filepath = filepath:sub(#cwd + 1)
  end

  if filepath:sub(-#filename) == filename then
    filepath = filepath:sub(1, -#filename - 1)
  end

  -- if filepath:sub(-1) == "/" then
  --   filepath = filepath:sub(1, -2)
  -- end

  local icon, color = require("nvim-web-devicons").get_icon_by_filetype(filetype, { color_icons = false })
  if icon == nil then
    color = ""
    icon = ""
  end

  if is_winbar then
    local _file = "%#DevIconConfig#" .. filename .. "%*"
    local _icon = "%#" .. color .. "#" .. icon .. "%*"
    return filepath .. _file .. _icon
    -- return "%#" .. color .. "#" .. icon .. "%* %#DevIconConfig#" .. filename .. " %*" .. filepath .. "%*"
  end

  return "%*" .. filepath .. filename .. "%*"
end

local function enable_winbar(win_id)
  local buf_id = vim.api.nvim_win_get_buf(win_id)
  local win_config = vim.api.nvim_win_get_config(win_id)

  local filetype = vim.bo[buf_id].filetype
  local is_floating = win_config.relative ~= ""

  -- local is_active = vim.api.nvim_get_current_win() == win_id
  -- local is_active_icon = ""
  -- if is_active then
  --   is_active_icon = ""
  -- end
  local is_active_icon = ""

  if is_floating or excluded_filetypes[filetype] ~= nil then
    vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
  else
    local winbar = ""
      .. is_active_icon
      .. " "
      .. get_filename(buf_id, true)
      .. " "
      .. get_modified(buf_id, true)
      .. " "
      -- .. "%="
      -- .. "%= %l/%L:%-3c"
      .. "%="
      .. get_diagnostics(buf_id)
      .. "%#Normal# %l/%L %*"

    vim.api.nvim_set_option_value("winbar", winbar, { win = win_id })
  end
end

--- @param win_id integer
--- @return nil
local function disable_winbar(win_id)
  vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
end

--- @param win_id integer
--- @return nil
local function enable_statusline(win_id)
  vim.opt.laststatus = 3

  local buf_id = vim.api.nvim_win_get_buf(win_id)
  local win_config = vim.api.nvim_win_get_config(win_id)

  local filetype = vim.bo[buf_id].filetype
  local is_floating = win_config.relative ~= ""

  if is_floating or excluded_filetypes[filetype] ~= nil then
    vim.api.nvim_set_option_value("statusline", statusline_cache[win_id], { win = win_id })
  else
    local statusline = " "
      .. get_filename(buf_id, false)
      .. " "
      .. get_modified(buf_id, false)
      .. " "
      .. "%= %l/%L:%-3c %y"
      .. " "
    statusline_cache[win_id] = statusline
    vim.api.nvim_set_option_value("statusline", statusline_cache[win_id], { win = win_id })
  end
end

local function disable_statusline()
  vim.opt.laststatus = 0
  vim.opt.statusline = "%{repeat('─', winwidth('.'))}"
end

--- Renderers
local function render_statusline()
  local group = _G.show_statusline and "StatusLineGlobal" or "StatusLineLocal"
  local group_nc = group .. "NC"

  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  local hl_nc = vim.api.nvim_get_hl(0, { name = group_nc, link = false })

  vim.api.nvim_set_hl(0, "StatusLine", { fg = hl.fg, bg = hl.bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = hl_nc.fg, bg = hl_nc.bg })

  if _G.show_statusline then
    enable_statusline(0)
  else
    disable_statusline()
  end
end

local function render_winbar()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if _G.show_winbar then
      enable_winbar(win)
    else
      disable_winbar(win)
    end
  end
end

local RenderGroup = vim.api.nvim_create_augroup("update_group", { clear = true })

--- Create Statusline autocmd and command
vim.api.nvim_create_autocmd("User", {
  pattern = "RefreshStatusline",
  group = RenderGroup,
  callback = function() end,
})

vim.api.nvim_create_user_command("ToggleStatusline", function()
  _G.show_statusline = not _G.show_statusline
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshStatusline" })
end, {})

--- Create Winbar autocmd and command
vim.api.nvim_create_autocmd("User", {
  pattern = "RefreshWinbar",
  group = RenderGroup,
  callback = function() end,
})

vim.api.nvim_create_user_command("ToggleWinbar", function()
  _G.show_winbar = not _G.show_winbar
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshWinbar" })
end, {})

--- Hide both
vim.api.nvim_create_user_command("ZenEnable", function()
  _G.show_statusline = false
  _G.show_winbar = false
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshStatusline" })
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshWinbar" })
end, {})

--- Show both
vim.api.nvim_create_user_command("ZenDisable", function()
  _G.show_statusline = true
  _G.show_winbar = true
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshStatusline" })
  vim.api.nvim_exec_autocmds("User", { pattern = "RefreshWinbar" })
end, {})

vim.api.nvim_create_user_command("ToggleHideAll", function()
  if _G.hide_all then
    vim.cmd("ZenDisable")
  else
    vim.cmd("ZenEnable")
  end
  _G.hide_all = not _G.hide_all
end, {})

--- Render Statusline and Winbar on autocmds...
vim.api.nvim_create_autocmd({
  "BufModifiedSet",
  "BufNewFile",
  "BufReadPost",
  "BufWritePost",
  "DiagnosticChanged",
  "TabClosed",
  "WinEnter",
}, {
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
