---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("blink.cmp").setup({
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
    },
    cmdline = {
      completion = {
        menu = { auto_show = true },
      },
      keymap = {
        -- ["<CR>"] = { "accept", "fallback" },
        --
        ["<Down>"] = { "show", "select_next", "fallback" },
        ["<Tab>"] = { "show", "select_next", "fallback" },
        --
        ["<Up>"] = { "select_prev", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
    snippets = {
      preset = "luasnip",
    },
    signature = {
      enabled = false,
      window = { border = "rounded" },
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      -- list = {
      --   selection = {
      --     preselect = function(ctx)
      --       return ctx.mode ~= "cmdline"
      --     end,
      --     auto_insert = function(ctx)
      --       return ctx.mode == "cmdline"
      --     end,
      --   },
      -- },
      menu = {
        auto_show = true,
        border = "rounded",
        draw = {
          columns = { { "kind_icon", gap = 1 }, { "label", "label_description" } },
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
        },
      },
    },
  })

  vim.cmd("hi! link BlinkCmpDocBorder FloatBorder")
  vim.cmd("hi! link BlinkCmpMenuBorder FloatBorder")
  vim.cmd("hi! link BlinkCmpSignatureHelpBorder FloatBorder")
  vim.cmd("hi! link BlinkCmpMenu NormalFloat")
end

return M
