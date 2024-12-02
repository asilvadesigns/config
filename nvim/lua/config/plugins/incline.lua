local M = {}

local get_diagnostics = function(props)
  local d_label = {}
  local d_count = vim.diagnostic.count(props.buf)
  local square = vim.fn.nr2char(0x25aa)

  if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.ERROR], group = "DiagnosticSignError" })
  end
  if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.HINT], group = "DiagnosticSignHint" })
  end
  if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.INFO], group = "DiagnosticSignInfo" })
  end
  if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
    table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.WARN], group = "DiagnosticSignWarn" })
  end

  return { d_label }
end

M.setup = function()
  require("incline").setup({
    highlight = {
      groups = {
        InclineNormal = { default = true, group = "Normal" },
        InclineNormalNC = { default = true, group = "Normal" },
      },
    },
    hide = {
      cursorline = false,
      focused_win = false,
      only_win = false
    },
    render = function(props)
      local diagnostics = get_diagnostics(props)
      local filename = { vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p:."), group = "Comment" }
      local modified = { " 󰆓 ", group = "Comment" }
      if vim.bo[props.buf].modified == true then
        modified = { " 󰆓 ", group = "DiagnosticSignWarn" }
      end

      return {
        diagnostics,
        modified,
        filename,
      }
    end,
  })

  vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
    group = vim.api.nvim_create_augroup("render_incline", { clear = true }),
    callback = function()
      vim.schedule(require("incline").refresh)
    end,
  })
end

return M
