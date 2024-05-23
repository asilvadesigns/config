return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    {
      "<leader>j",
      function()
        local filetype = vim.bo.filetype

        if filetype == "NvimTree" then
          vim.cmd("NvimTreeClose")
        else
          vim.cmd("NvimTreeFindFile")
        end
      end,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filesystem_watchers = {
        ignore_dirs = {
          "node_modules",
        },
      },
      filters = {
        dotfiles = false,
        -- exclude = { "\\._templ.txt$" }
      },
      git = {
        enable = false,
        ignore = false,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = false,
          ignore_list = {},
        },
        exclude = false,
      },
      view = {
        width = 40,
      },
    })

    vim.cmd("highlight link NvimTreeIndentMarker LineNr")
  end,
}
