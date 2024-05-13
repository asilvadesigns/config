return {
  "nvim-tree/nvim-tree.lua",
  event = { "VeryLazy" },
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
      },
      git = {
        enable = false,
        ignore = false,
      },
      renderer = {
        indent_markers = {
          enable = false,
        },
      },
      view = {
        width = 40,
      },
    })

    vim.cmd("highlight link NvimTreeIndentMarker LineNr")
  end,
}
