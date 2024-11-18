local M = {}

M.setup = function()
  vim.cmd("highlight clear")
  vim.g.colors_name = "minimal"

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local fg = "#002b36"
      local bg = "#fdf6e3"

      local highlight_groups = {
        -- global::bg
        Normal = { fg = fg, bg = bg },
        NormalFloat = { fg = fg, bg = bg },
        -- global::numbers
        LineNr = { fg = fg },
        -- global::cursor
        Cursor = { fg = fg, bg = bg },
        CursorLine = { bg = bg },
        -- global::status line
        StatusLine = { fg = fg, bg = bg },
        StatusLineNC = { fg = fg, bg = bg },
        -- global::window bar
        Winbar = { fg = fg, bg = bg },
        WinbarNC = { fg = fg, bg = bg },
        -- syntax::basic
        Character = { fg = fg },
        Comment = { fg = fg },
        Constant = { fg = fg },
        Delimeter = { fg = fg },
        Function = { fg = fg },
        Identifier = { fg = fg },
        Keyword = { fg = fg },
        Label = { fg = fg },
        Macro = { fg = fg },
        Number = { fg = fg },
        Operator = { fg = fg },
        Special = { fg = fg },
        SpecialChar = { fg = fg },
        Statement = { fg = fg },
        String = { fg = fg },
        Structure = { fg = fg },
        Type = { fg = fg },
        -- syntax::lua
        ["@keyword.lua"] = { fg = fg }, --#BB0000
        ["@keyword.conditional.lua"] = { fg = fg },
        ["@keyword.function.lua"] = { fg = fg },
        ["@keyword.repeat.lua"] = { fg = fg },
        ["@string"] = { fg = fg },
        ["@comment"] = { fg = "#008800" }, --#0000FB
        -- syntax::jsdoc
        ["@keyword.jsdoc"] = { fg = "#008800" },
        ["@punctuation.bracket.jsdoc"] = { fg = "#008800" },
        ["@type.jsdoc"] = { fg = "#008800" },
        ["@variable.parameter.jsdoc"] = { fg = "#008800" },
      }

      for group, settings in pairs(highlight_groups) do
        vim.api.nvim_set_hl(0, group, settings)
      end
    end,
  })
end

M.load = function()
  vim.cmd("colorscheme minimal")
end

return M
