local M = {}

M.setup = function()
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintIcon", { link = "DiagnosticSignHint" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorIcon", { link = "DiagnosticSignError" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnIcon", { link = "DiagnosticSignWarn" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoIcon", { link = "DiagnosticSignInfo" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintFileHL", { link = "DiagnosticSignHint" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorFileHL", { link = "DiagnosticSignError" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnFileHL", { link = "DiagnosticSignWarn" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoFileHL", { link = "DiagnosticSignInfo" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintFolderHL", { link = "DiagnosticSignHint" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorFolderHL", { link = "DiagnosticSignError" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnFolderHL", { link = "DiagnosticSignWarn" })
  -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoFolderHL", { link = "DiagnosticSignInfo" })

  local options = require("config.options")

  require("nvim-tree").setup({
    -- on_attach = function(bufnr)
    --   local api = require("nvim-tree.api")
    --
    --   local function opts(desc)
    --     return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    --   end
    --
    --   vim.keymap.set("n", "<CR>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
    --   -- file system
    --   vim.keymap.set("n", "a", api.fs.create, opts("Create"))
    --   vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
    --   vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
    --   -- tree
    --   vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
    --   -- help
    --   vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
    -- end,
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
      highlight_diagnostics = "all",
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
      signcolumn = "no",
    },
  })

  vim.cmd("hi! link NvimTreeIndentMarker LineNr")

  vim.cmd("hi! link NvimTreeFolderName Delimiter")
  vim.cmd("hi! link NvimTreeNormal Delimiter")
  vim.cmd("hi! link NvimTreeOpenedFolderName Delimiter")
  vim.cmd("hi! link NvimTreeRootFolder Delimiter")

  vim.cmd("hi! link NvimTreeDiagnosticErrorFileHL DiagnosticSignError")
  vim.cmd("hi! link NvimTreeDiagnosticHintFileHL DiagnosticSignHint")
  vim.cmd("hi! link NvimTreeDiagnosticInfoFileHL DiagnosticSignInfo")
  vim.cmd("hi! link NvimTreeDiagnosticWarnFileHL DiagnosticSignWarn")

  vim.cmd("hi! link NvimTreeDiagnosticErrorFolderHL DiagnosticSignError")
  vim.cmd("hi! link NvimTreeDiagnosticHintFolderHL DiagnosticSignHint")
  vim.cmd("hi! link NvimTreeDiagnosticInfoFolderHL DiagnosticSignInfo")
  vim.cmd("hi! link NvimTreeDiagnosticWarnFolderHL DiagnosticSignWarn")
end

return M
