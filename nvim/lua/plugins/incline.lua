return {
  "b0o/incline.nvim",
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "VeryLazy" },
  enabled = false,
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
        local diagnostic_data = {
          Error = "󰅚 ",
          Hint = "󰌶 ",
          Info = " ",
          Warn = "󰀪 ",
        }

        local diagnostics = ""

        for level, sign in pairs(diagnostic_data) do
          local count = vim.tbl_count(vim.diagnostic.get(props.buf, { severity = level }))
          diagnostics = diagnostics .. (count >= 1 and sign .. count .. " " or "")
        end

        -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        -- local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.:h") .. "/"
        -- local modified = vim.bo[props.buf].modified

        return {
          { diagnostics },
          -- { diagnostics .. "  " },
          -- { filepath .. filename },
          -- modified and " *" or "  ",
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
