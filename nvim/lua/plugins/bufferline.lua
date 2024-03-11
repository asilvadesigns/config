return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>t<", ":tabprevious<CR>" },
    { "<leader>t>", ":tabnext<CR>" },
    { "<leader>tc", ":tabclose<CR>" },
    { "<leader>tl", ":tablast<CR>" },
    { "<leader>tn", ":tabnew<CR>" },
  },
  event = { "VeryLazy" },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
          all = {
            fill = {
              bg = colors.mantle,
            },
            indicator_selected = {
              fg = colors.blue,
            },
          },
        },
      }),
      options = {
        always_show_bufferline = false,
        show_duplicate_prefix = false,
        mode = "tabs",
        offsets = {
          {
            filetype = "NvimTree",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
            text = "",
          },
        },
      },
    })
  end,
}
