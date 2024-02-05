return {
  "b0o/incline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = { "VeryLazy" },
  config = function()
    require('incline').setup({
      window = {
        margin = {
          horizontal = 0,
          vertical = 1
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.api.nvim_get_option_value("modified", { buf = props.buf }) and 'italic' or ''

        local buffer = {
          { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
          { filename .. " ",        gui = modified },
        }

        return buffer
      end
    })
  end
}
