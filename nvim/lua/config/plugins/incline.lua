local M = {}

local get_diagnostic_label = function(props)
  local label = {}
  local count = vim.diagnostic.count(props.buf)
  local square = vim.fn.nr2char(0x25aa)

  if count[vim.diagnostic.severity.ERROR] and count[vim.diagnostic.severity.ERROR] > 0 then
    table.insert(label, { square .. count[vim.diagnostic.severity.ERROR], group = "DiagnosticSignError" })
  end
  if count[vim.diagnostic.severity.HINT] and count[vim.diagnostic.severity.HINT] > 0 then
    table.insert(label, { square .. count[vim.diagnostic.severity.HINT], group = "DiagnosticSignHint" })
  end
  if count[vim.diagnostic.severity.INFO] and count[vim.diagnostic.severity.INFO] > 0 then
    table.insert(label, { square .. count[vim.diagnostic.severity.INFO], group = "DiagnosticSignInfo" })
  end
  if count[vim.diagnostic.severity.WARN] and count[vim.diagnostic.severity.WARN] > 0 then
    table.insert(label, { square .. count[vim.diagnostic.severity.WARN], group = "DiagnosticSignWarn" })
  end

  return label
end

M.setup = function()
  require("incline").setup({
    hide = {
      cursorline = false,
    },
    -- highlight = {
    --   groups = {
    --     InclineNormal = { guibg = "none", guifg = colors.surface2 },
    --     InclineNormalNC = { guibg = "none", guifg = colors.surface2 },
    --   },
    -- },
    render = function(props)
      local diagnostics = get_diagnostic_label(props)
      -- local modified = get_modified_label(props, colors.yellow, colors.crust)

      return {
        { diagnostics },
        -- { modified },
      }
    end,
    window = {
      margin = {
        horizontal = 0,
        vertical = 1,
      },
    },
  })
end

return M
