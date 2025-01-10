local M = {}

M.setup = function()
  local signs = require("config.signs")

  local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "I", api.tree.toggle_enable_filters, {
      desc = "nvim-tree: Toggle filters",
      buffer = bufnr,
      nowait = true,
      silent = true,
    })

    vim.keymap.set("n", "f", function()
      local node = api.tree.get_node_under_cursor()
      local path = node.absolute_path

      if node.type == "directory" then
        path = path .. "/"
      end

      local grug_far = require("grug-far")
      if not grug_far.has_instance("explorer") then
        grug_far.open({
          instanceName = "explorer",
          prefills = { paths = path },
          staticTitle = "Find and Replace from Explorer",
        })
      else
        grug_far.open_instance("explorer")
        grug_far.update_instance_prefills("explorer", { paths = path }, false)
      end
    end, {
      desc = "nvim-tree: Search in directory",
      buffer = bufnr,
      nowait = true,
      silent = true,
    })
  end

  require("nvim-tree").setup({
    sync_root_with_cwd = true,
    on_attach = my_on_attach,
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = signs.diagnostics.Hint,
        info = signs.diagnostics.Info,
        warning = signs.diagnostics.Warn,
        error = signs.diagnostics.Error,
      },
    },
    filesystem_watchers = {
      ignore_dirs = {
        "node_modules",
      },
    },
    filters = {
      -- custom = { "^.git$", ".*_templ.txt$" },
      custom = { ".*_templ.txt$" },
    },
    live_filter = {
      always_show_folders = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      highlight_diagnostics = "all",
      icons = {
        show = {
          bookmarks = true,
          diagnostics = true,
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
          modified = true,
        },
        git_placement = "after",
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
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
            ignored = "󱙝", -- 󰊠
          },
        },
      },
    },
    update_focused_file = {
      enable = false, -- just use <leader>j for this, see below
      update_root = {
        enable = false,
        ignore_list = {},
      },
      exclude = false,
    },
    view = {
      width = 40,
      -- signcolumn = "no",
    },
  })
end

vim.keymap.set("n", "<leader>j", function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("NvimTreeClose")
  else
    local current_file = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()

    if vim.fn.filereadable(current_file) == 1 and string.sub(current_file, 1, #cwd) == cwd then
      vim.cmd("NvimTreeFindFile")
      vim.cmd("normal! zz")
    else
      vim.cmd("NvimTreeOpen")
    end
  end
end, { desc = "Toggle file tree" })

return M
