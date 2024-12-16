-- ---@return string
-- local function get_tmux_panes()
--   -- Run the command and capture the output
--   local handle = io.popen("tmux list-panes | wc -l")
--   if handle ~= nil then
--     local result = handle:read("*a")
--     handle:close()
--     -- Trim any whitespace from the output
--     result = result:gsub("%s+", "")
--     return result
--   end
--
--   return ""
-- end

---@param buf_id integer
---@return string
local function get_diagnostics(buf_id)
  local d_count = vim.diagnostic.count(buf_id)
  local d_label = ""
  local square = vim.fn.nr2char(0x25aa)

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
---@return string
local function get_filename(buf_id)
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

  return "%*%#NonText#" .. filepath .. "/" .. "%*%#Normal#" .. filename .. "%*"
end

---@return nil
local function main()
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local win_config = vim.api.nvim_win_get_config(win_id)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_id })
    local is_floating = win_config.relative ~= ""

    if is_floating then
      vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
      break
    end

    if filetype == "NvimTree" then
      vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
      break
    end

    -- .. "%=%l/%L:%c%*"
    vim.api.nvim_set_option_value(
      "winbar",
      " "
        .. get_filename(buf_id)
        .. " "
        .. get_modified(buf_id)
        .. " "
        .. get_diagnostics(buf_id)
        .. "%*%#NonText# %=%l/%L%* %*",
      { win = win_id }
    )
  end
end

--- NOTE: when to render the winbar
vim.api.nvim_create_autocmd({
  "BufModifiedSet",
  "BufNewFile",
  "BufReadPre",
  "DiagnosticChanged",
  "TabClosed",
}, {
  group = vim.api.nvim_create_augroup("render_ui", { clear = true }),
  callback = function()
    vim.schedule(main)
  end,
})
