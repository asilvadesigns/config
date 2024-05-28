local function get_diagnostic_label(props)
  local icons = {
    Error = { icon = "󰅚" },
    Hint = { icon = "󰌶" },
    Info = { icon = "" },
    Warn = { icon = "󰀪" },
  }

  local label = {}
  for severity, data in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if n > 0 then
      table.insert(label, { data.icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
    end
  end
  return label
end

local function get_modified_label(props, modified, base)
  local label = {}
  local is_modified = vim.bo[props.buf].modified
  if is_modified then
    table.insert(label, { " ", guifg = modified })
  else
    table.insert(label, { " ", guifg = base })
  end
  return label
end

return {
  "b0o/incline.nvim",
  enabled = false,
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

    require("incline").setup({
      hide = {
        cursorline = false,
      },
      highlight = {
        groups = {
          InclineNormal = { guibg = "none", guifg = colors.surface2 },
          InclineNormalNC = { guibg = "none", guifg = colors.surface2 },
        },
      },
      render = function(props)
        -- local diagnostics = get_diagnostic_label(props)
        -- local modified = get_modified_label(props, colors.yellow, colors.crust)

        local buf_name = vim.api.nvim_buf_get_name(props.buf)

        -- local sep = "  "
        local filename = vim.fn.fnamemodify(buf_name, ":t")
        -- local filepath = " " .. string.gsub(vim.fn.fnamemodify(buf_name, ":~:.:h"), "/", sep) .. sep
        local filepath = vim.fn.fnamemodify(buf_name, ":~:.:h") .. "/"

        return {
          { filepath },
          { filename },
        }
      end,
      window = {
        margin = {
          horizontal = 1,
          vertical = 1,
        },
      },
    })

    vim.api.nvim_create_user_command("InclineToggle", function()
      require("incline").toggle()
    end, {})
  end,
}
