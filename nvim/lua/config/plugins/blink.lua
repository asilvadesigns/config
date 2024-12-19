---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("blink.cmp").setup({
    keymap = {
      preset = "enter",
    },
    completion = {
      list = {
        selection = "manual",
      },
      menu = {
        draw = {
          columns = { { "kind_icon", gap = 1 }, { "label", "label_description" } },
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = false,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  })
end

return M
