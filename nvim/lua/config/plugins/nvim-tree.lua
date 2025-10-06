local M = {}

M.setup = function()
  local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "I", api.tree.toggle_enable_filters, {
      desc = "nvim-tree: Toggle filters",
      buffer = bufnr,
      nowait = true,
      silent = true,
    })

    -- vim.keymap.set("n", "d", function()
    --   vim.notify("could not delete")
    -- end, opts("Delete"))
    --
    -- vim.keymap.set("n", "D", function()
    --   vim.notify("could not put in trash")
    -- end, opts("Trash"))
    vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
    vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))

    -- search directory with grug
    vim.keymap.set("n", "f", function()
      local node = api.tree.get_node_under_cursor()
      local path = node.absolute_path

      if node.type == "directory" then
        path = path .. "/"
      end

      local grugfar = require("grug-far")
      local options = {
        instanceName = _G.grug_instance_global,
        prefills = {
          paths = path,
          search = grugfar.get_current_visual_selection(),
        },
      }
      if grugfar.has_instance(options.instanceName) then
        grugfar.get_instance(options.instanceName):update_input_values(options.prefills, false)
        grugfar.get_instance(options.instanceName):open()
      else
        grugfar.toggle_instance(options)
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
      enable = false,
      show_on_dirs = false,
    },
    -- filesystem_watchers = {
    --   ignore_dirs = {
    --     "node_modules",
    --   },
    -- },
    filters = {
      custom = { ".*_templ.txt$" }, -- "^.git$"
    },
    live_filter = {
      always_show_folders = false,
    },
    git = {
      enable = false,
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
            untracked = "",
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
      cursorline = true,
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
end, { silent = true, desc = "Open file in file tree" })

return M
