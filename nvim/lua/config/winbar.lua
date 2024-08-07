local M = {}

---@return string
local function get_diagnostics()
  local d_count = vim.diagnostic.count(0)
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

---@return string
local function get_filename()
  local filename = vim.fn.expand("%:t")
  local filepath = vim.fn.expand("%:~:.:h")
  local filetype = vim.bo.filetype

  if filetype == "oil" then
    return vim.fn.expand("%:~:h")
  end

  if filetype == "NvimTree" then
    return ""
  end

  if filename == "" then
    return ""
  end

  -- local sep = "  "
  -- local filepath = " " .. string.gsub(vim.fn.expand("%:~:.:h"), "/", sep) .. sep

  return filepath .. "/" .. "%*%#Normal#" ..  filename .. "%*"
end

---@return nil
local function main()
  local is_floating = vim.api.nvim_win_get_config(0).relative ~= ""

  if is_floating then
    vim.opt_local.winbar = nil
  else
    vim.opt_local.winbar = " " .. get_filename() .. " " .. get_diagnostics()
  end
end

vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufModifiedSet",
  "DiagnosticChanged",
  "TabClosed",
}, {
  group = vim.api.nvim_create_augroup("render_ui", { clear = true }),
  callback = function()
    vim.schedule(main)
  end,
})

return M
