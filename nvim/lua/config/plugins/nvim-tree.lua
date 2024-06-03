local M = {}

M.setup = function()
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
        enable = false,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
          modified = true,
          diagnostics = true,
          bookmarks = true,
        },
        web_devicons = {
          file = {
            enable = true,
            color = false,
          },
          folder = {
            enable = true,
            color = false,
          },
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "󰆤",
          modified = "●",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
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
end

return M
