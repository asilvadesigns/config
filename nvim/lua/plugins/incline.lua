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

return {
  "b0o/incline.nvim",
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "VeryLazy" },
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
        local diagnostics = get_diagnostic_label(props)

        -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        -- local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.:h") .. "/"
        -- local modified = vim.bo[props.buf].modified

        return {
          { diagnostics },
        }
      end,
      window = {
        margin = {
          horizontal = 0,
          vertical = 1,
        },
      },
    })

    vim.api.nvim_create_user_command("InclineToggle", function()
      require("incline").toggle()
    end, {})
  end,
}
