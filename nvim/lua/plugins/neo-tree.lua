return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = { "Neotree" },
  keys = {
    {
      "<leader>j",
      "<CMD>NeoTreeReveal<CR>",
      desc = "reveal file in explorer",
    },
    {
      "<leader>x",
      "<CMD>Neotree position=current reveal_file=%:p<CR>",
      desc = "reveal file in current buffer",
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("neo-tree").setup({
      enable_diagnostics = false,
      enable_git_status = false,
      enable_modified_markers = false,
      open_files_do_not_replace_types = {
        "Mason",
        "Outline",
        "Telescope",
        "Trouble",
        "qf",
        "terminal",
        "trouble",
      },
      buffers = {
        follow_current_file = false,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = false,
        hijack_netrw_behavior = "open_current",
        renderers = {
          file = {
            { "indent" },
            { "icon" },
            { "name" },
          },
        },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          indent_marker = "│",
          indent_size = 2,
          last_indent_marker = "└",
          with_markers = false,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
        },
      },
      use_default_mappings = false,
      window = {
        mappings = {
          -- operations
          ["<cr>"] = "open",
          ["<space>"] = "toggle_node",
          ["A"] = "add_directory",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          -- movements
          ["<bs>"] = "navigate_up",
          -- searching
          ["#"] = "fuzzy_sorter",
          ["<c-x>"] = "clear_filter",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          -- splits
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          -- toggle
          ["H"] = "toggle_hidden",
          ["R"] = "refresh",
        },
      },
    })

    vim.keymap.set("n", "<S-Esc>", "<cmd>NeoTreeClose<cr>", { desc = "Close NeoTree" })
  end,
}
