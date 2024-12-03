local M = {}

M.setup = function()
  local options = require("config.options")

  local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")
    local lib = require("nvim-tree.lib")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "I", api.tree.toggle_enable_filters, opts("Up"))

    vim.keymap.set("n", "f", function()
      local node = lib.get_node_at_cursor()
      local grugFar = require("grug-far")
      if node then
        -- get directory of current file if it's a file
        local path
        if node.type == "directory" then
          -- Keep the full path for directories
          path = node.absolute_path
        else
          -- Get the directory of the file
          path = vim.fn.fnamemodify(node.absolute_path, ":h")
        end

        -- escape all spaces in the path with "\ "
        path = path:gsub(" ", "\\ ")

        local prefills = {
          paths = path,
        }

        -- instance check
        if not grugFar.has_instance("tree") then
          grugFar.open({
            instanceName = "tree",
            prefills = prefills,
            staticTitle = "Find and Replace from Tree",
          })
        else
          grugFar.open_instance("tree")
          -- updating the prefills without clearing the search and other fields
          grugFar.update_instance_prefills("tree", prefills, false)
        end
      end
    end, opts("Search in directory"))
  end

  vim.cmd("set laststatus=0")
  require("nvim-tree").setup({
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
        hint = options.signs.Hint,
        info = options.signs.Info,
        warning = options.signs.Warn,
        error = options.signs.Error,
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
      enable = true,
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
  vim.cmd("set laststatus=0")

  -- vim.cmd("hi! link NvimTreeFolderIcon Comment") -- LineNr
  -- vim.cmd("hi! link NvimTreeFileIcon Comment") -- LineNr
  --
  -- vim.cmd("hi! link NvimTreeIndentMarker WinSeparator") -- LineNr

  -- vim.cmd("hi! link NvimTreeOpenedFolderIcon Delimiter")
  --
  -- vim.cmd("hi! link NvimTreeFolderName Delimiter")
  -- vim.cmd("hi! link NvimTreeFolderName Normal")

  -- vim.cmd("hi! link NvimTreeNormal Normal")
  -- vim.cmd("hi! link NvimTreeEndOfBuffer Normal")

  -- vim.cmd("hi! link NvimTreeOpenedFolderName Delimiter")
  -- vim.cmd("hi! link NvimTreeRootFolder Delimiter")
  --
  -- vim.cmd("hi! link NvimTreeGitIgnored LineNr")
  -- vim.cmd("hi! link NvimTreeGitIgnoredIcon LineNr")
  -- vim.cmd("hi! link NvimTreeGitFileIgnoredHL LineNr")
  -- vim.cmd("hi! link NvimTreeGitFolderIgnoredHL LineNr")
  --
  -- vim.cmd("hi! link NvimTreeDiagnosticErrorFileHL DiagnosticSignError")
  -- vim.cmd("hi! link NvimTreeDiagnosticHintFileHL DiagnosticSignHint")
  -- vim.cmd("hi! link NvimTreeDiagnosticInfoFileHL DiagnosticSignInfo")
  -- vim.cmd("hi! link NvimTreeDiagnosticWarnFileHL DiagnosticSignWarn")
  --
  -- vim.cmd("hi! link NvimTreeDiagnosticErrorFolderHL DiagnosticSignError")
  -- vim.cmd("hi! link NvimTreeDiagnosticHintFolderHL DiagnosticSignHint")
  -- vim.cmd("hi! link NvimTreeDiagnosticInfoFolderHL DiagnosticSignInfo")
  -- vim.cmd("hi! link NvimTreeDiagnosticWarnFolderHL DiagnosticSignWarn")

  -- vim.keymap.set("n", "<leader>j", function()
  --   local filetype = vim.bo.filetype
  --
  --   if filetype == "NvimTree" then
  --     vim.cmd("NvimTreeClose")
  --   else
  --     vim.cmd("NvimTreeFindFile")
  --   end
  -- end, {})

  local nt_api = require("nvim-tree.api")
  nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
    vim.cmd("set laststatus=0")
  end)

  nt_api.events.subscribe(nt_api.events.Event.TreeClose, function()
    vim.cmd("set laststatus=0")
  end)
end

return M
