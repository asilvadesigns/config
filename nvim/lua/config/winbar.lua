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

local last_winbar = {}

---
---
---
local RenderGroup = vim.api.nvim_create_augroup("update_winbar", { clear = true })

local function update_winbar(win_id)
  local buf_id = vim.api.nvim_win_get_buf(win_id)
  local win_config = vim.api.nvim_win_get_config(win_id)

  local filetype = vim.bo[buf_id].filetype
  local is_floating = win_config.relative ~= ""

  if is_floating or filetype == "NvimTree" or filetype == "toggleterm" then
    if last_winbar[win_id] then
      vim.api.nvim_set_option_value("winbar", nil, { win = win_id })
      last_winbar[win_id] = nil
    end
  else
    local new_winbar = " "
      .. get_filename(buf_id)
      .. " "
      .. get_modified(buf_id)
      .. " "
      .. get_diagnostics(buf_id)
      .. "%*%#NonText# %=%l/%L%* %*"

    if new_winbar ~= last_winbar[win_id] then
      vim.api.nvim_set_option_value("winbar", new_winbar, { win = win_id })
      last_winbar[win_id] = new_winbar
    end
  end
end

vim.api.nvim_create_autocmd({
  "BufModifiedSet",
  "BufNewFile",
  "BufReadPre",
  "DiagnosticChanged",
  "TabClosed",
}, {
  group = RenderGroup,
  callback = function(args)
    vim.schedule(function()
      for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
        update_winbar(win)
      end
    end)
  end,
})
