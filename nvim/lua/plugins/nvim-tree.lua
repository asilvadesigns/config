return {
  "nvim-tree/nvim-tree.lua",
  event = { "VeryLazy" },
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
        enable = true,
        debounce_delay = 50,
        ignore_dirs = { "node_modules" },
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
          enable = true,
        },
      },
      view = {
        width = 40,
      },
    })

    vim.cmd("highlight link NvimTreeIndentMarker LineNr")

    -- @see: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#eliasa5
    vim.api.nvim_create_autocmd({ "QuitPre" }, {
      callback = function()
        vim.cmd("NvimTreeClose")
      end,
    })

    vim.keymap.set("n", "<leader>j", function()
      local filetype = vim.bo.filetype

      if filetype == "NvimTree" then
        vim.cmd("NvimTreeClose")
      else
        vim.cmd("NvimTreeFindFile")
      end
    end, {})
  end,
}
