local M = {}

M.setup = function()
  local plugin = require("oil")
  plugin.setup({
    default_file_explorer = true,
    constrain_cursor = "name",
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
    },
    win_options = {
      signcolumn = "yes",
    },
    columns = {
      {
        "icon",
        directory = "",
        default_file = "",
      },
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      -- ["<C-s>"] = "actions.select_vsplit",
      -- ["<C-h>"] = "actions.select_split",
      -- ["<C-t>"] = "actions.select_tab",
      -- ["<C-p>"] = "actions.preview",
      -- ["<C-c>"] = "actions.close",
      -- ["<C-l>"] = "actions.refresh",
      ["K"] = "actions.parent",
      -- ["_"] = "actions.open_cwd",
      -- ["`"] = "actions.cd",
      -- ["~"] = "actions.tcd",
      -- ["gs"] = "actions.change_sort",
      -- ["gx"] = "actions.open_external",
      -- ["g."] = "actions.toggle_hidden",
      -- ["g\\"] = "actions.toggle_trash",
    },
  })

  vim.keymap.set("n", "<leader>x", ":Oil<CR>", { desc = "Show Oil" })

  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "oil",
  --   callback = function()
  --     vim.keymap.set("n", "K", function()
  --       vim.wo.cursorline = false
  --       vim.cmd("normal! gg")
  --       plugin.select()
  --       vim.wo.cursorline = true
  --     end, { buffer = true })
  --   end,
  -- })

  -- vim.cmd("hi! link OilDir NvimTreeFolderName")
  -- vim.cmd("hi! link OilDirIcon NvimTreeFolderName")
  -- vim.cmd("hi! link OilFile NvimTreeFolderName")
end

return M
