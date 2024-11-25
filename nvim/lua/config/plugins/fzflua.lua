local M = {}

M.setup = function()
  local actions = require("fzf-lua.actions")

  require("fzf-lua").setup({
    winopts = {
      height = 0.60, -- window height
      width = 0.60, -- window width
      row = 0.50, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      backdrop = 100,
    },
    -- keymap = {
    --   fzf = {
    --     ["ctrl-q"] = "select-all+accept",
    --     ["ctrl-b"] = "toggle-all",
    --   },
    -- },
    -- actions = {
    --   -- Below are the default actions, setting any value in these tables will override
    --   -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    --   -- ['ctrl-space'] = actions.toggle_select,
    --   -- ["ctrl-q"] = actions.file_sel_to_qf,
    --   -- {
    --   --   fn = function(selected, opts)
    --   --     vim.print(vim.inspect(selected))
    --   --     -- if #selected > 1 then
    --   --     --   -- build the quickfix list from the selected items
    --   --     --   require("fzf-lua").actions.file_sel_to_qf(selected, opts)
    --   --     --
    --   --     --   -- call the command to open the 'trouble.nvim' interface
    --   --     --   vim.cmd("<trouble nvim command>")
    --   --     -- else
    --   --     --   require("fzf-lua").actions.file_edit(selected, opts)
    --   --     -- end
    --   --   end,
    --   --   prefix = "select-all+",
    --   -- },
    --   files = {
    --     false, -- do not inherit from defaults
    --     -- Pickers inheriting these actions:
    --     --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
    --     --   tags, btags, args, buffers, tabs, lines, blines
    --     -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
    --     -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
    --     -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
    --     ["enter"] = actions.file_edit_or_qf,
    --     ["ctrl-s"] = actions.file_split,
    --     ["ctrl-v"] = actions.file_vsplit,
    --     -- ["ctrl-t"] = actions.file_tabedit,
    --     -- ["ctrl-q"] = actions.file_sel_to_qf,
    --     ["alt-Q"] = actions.file_sel_to_ll,
    --   },
    -- },
    commands = {
      previewer = false,
    },
    files = {
      previewer = false,
    },
    oldfiles = {
      previewer = false,
    },
    blines = {
      previewer = false,
    },
    lsp = {
      previewer = false,
    },
  })

  require("fzf-lua").register_ui_select()
end

return M
