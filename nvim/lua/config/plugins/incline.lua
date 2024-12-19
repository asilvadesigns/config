local M = {}

local get_diagnostics = function(props)
  local d_label = {}
  local d_count = vim.diagnostic.count(props.buf)

  local square = vim.fn.nr2char(0x25aa)

  if d_count[vim.diagnostic.severity.ERROR] and d_count[vim.diagnostic.severity.ERROR] > 0 then
    -- table.insert(d_label, { " " .. d_count[vim.diagnostic.severity.ERROR], group = "DiagnosticSignError" })
    -- table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.ERROR], group = "DiagnosticSignError" })
    table.insert(d_label, { square, group = "DiagnosticSignError" })
  end
  if d_count[vim.diagnostic.severity.HINT] and d_count[vim.diagnostic.severity.HINT] > 0 then
    -- table.insert(d_label, { " " .. d_count[vim.diagnostic.severity.HINT], group = "DiagnosticSignHint" })
    -- table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.HINT], group = "DiagnosticSignHint" })
    table.insert(d_label, { square, group = "DiagnosticSignHint" })
  end
  if d_count[vim.diagnostic.severity.INFO] and d_count[vim.diagnostic.severity.INFO] > 0 then
    -- table.insert(d_label, { " " .. d_count[vim.diagnostic.severity.INFO], group = "DiagnosticSignInfo" })
    -- table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.INFO], group = "DiagnosticSignInfo" })
    table.insert(d_label, { square, group = "DiagnosticSignInfo" })
  end
  if d_count[vim.diagnostic.severity.WARN] and d_count[vim.diagnostic.severity.WARN] > 0 then
    -- table.insert(d_label, { " " .. d_count[vim.diagnostic.severity.WARN], group = "DiagnosticSignWarn" })
    -- table.insert(d_label, { " " .. square .. d_count[vim.diagnostic.severity.WARN], group = "DiagnosticSignWarn" })
    table.insert(d_label, { square, group = "DiagnosticSignWarn" })
  end

  --- padding
  table.insert(d_label, " ")

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
      only_win = false,
    },
    ignore = {
      unlisted_buffers = false,
      filetypes = { "NvimTree" },
      buftypes = {},
    },
    render = function(props)
      local diagnostics = get_diagnostics(props)
      -- local filename = { vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p:."), group = "Comment" }

      local filename = { vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t"), group = "Comment" }
      -- local filetype = " " .. vim.api.nvim_get_option_value("filetype", { buf = props.buf })

      -- local modified = { " 󰆓 ", group = "Comment" }
      -- if vim.bo[props.buf].modified == true then
      --   modified = { " 󰆓 ", group = "DiagnosticSignWarn" }
      -- end

      return {
        diagnostics,
        -- modified,
        filename,
        -- filetype,
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
