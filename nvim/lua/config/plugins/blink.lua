local M = {}

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.setup = function()
  require("blink.cmp").setup({
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    ---@diagnostic disable-next-line: missing-fields
    completion = {
      list = {
        selection = "manual",
      },
    },
    keymap = { preset = "enter" },
    -- keymap = {
    --   ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
    --   ["<Up>"] = { "select_prev", "fallback" },
    --   ["<Down>"] = { "select_next", "fallback" },
    --   ["<C-N>"] = { "select_next", "show" },
    --   ["<C-P>"] = { "select_prev", "show" },
    --   ["<C-J>"] = { "select_next", "fallback" },
    --   ["<C-K>"] = { "select_prev", "fallback" },
    --   ["<C-U>"] = { "scroll_documentation_up", "fallback" },
    --   ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    --   ["<C-e>"] = { "hide", "fallback" },
    --   ["<CR>"] = { "accept", "fallback" },
    --   ["<Tab>"] = {
    --     function(cmp)
    --       if cmp.windows.autocomplete.win:is_open() then
    --         return cmp.select_next()
    --       elseif cmp.is_in_snippet() then
    --         return cmp.snippet_forward()
    --       elseif has_words_before() then
    --         return cmp.show()
    --       end
    --     end,
    --     "fallback",
    --   },
    --   ["<S-Tab>"] = {
    --     function(cmp)
    --       if cmp.windows.autocomplete.win:is_open() then
    --         return cmp.select_prev()
    --       elseif cmp.is_in_snippet() then
    --         return cmp.snippet_backward()
    --       end
    --     end,
    --     "fallback",
    --   },
    -- },

    ---@diagnostic disable-next-line: missing-fields
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    ---@diagnostic disable-next-line: missing-fields
    sources = {
      completion = {
        enabled_providers = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
    },
    -- experimental auto-brackets support
    -- completion = { accept = { auto_brackets = { enabled = true } } }

    -- experimental signature help support
    -- signature = { enabled = true }
  })
end

return M
