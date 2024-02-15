return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = {
      "VeryLazy",
    },
    keys = {
      { "<leader>j", "<CMD>NvimTreeFindFile<CR>" },
    },
    -- no idea why this doesn't work, w/e
    lazy = false,
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
        view = {
          width = 40,
        },
      })

      -- @see: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#eliasa5
      vim.api.nvim_create_autocmd({ "QuitPre" }, {
        callback = function()
          vim.cmd("NvimTreeClose")
        end,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    cmd = {
      "Neotree",
    },
    keys = {
      { "<leader>j", "<CMD>Neotree reveal<CR>" },
      { "<leader><space>", "<CMD>Neotree position=current reveal_file=%:p<CR>" },
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
          follow_current_file = {
            enabled = false,
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = false,
          },
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
            ["c"] = "copy",
            ["p"] = "paste_from_clipboard",
            ["m"] = "move",
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
  },
}
