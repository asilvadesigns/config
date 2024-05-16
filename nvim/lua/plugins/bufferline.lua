return {
  "akinsho/bufferline.nvim",
  enabled = false,
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "VeryLazy" },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
          all = {
            fill = { bg = colors.mantle },
            indicator_selected = { fg = colors.blue },
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
            separator = false, -- use a "true" to enable the default, or set your own character
            text = "",
          },
        },
      },
    })
  end,
}
