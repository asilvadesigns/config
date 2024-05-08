return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
    opts = { signcolumn = false },
  },
  {
    "NeogitOrg/neogit",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = {},
  },
  {
    "rhysd/conflict-marker.vim",
    event = { "VeryLazy" },
    enabled = false,
    init = function()
      vim.cmd([[
      let g:conflict_marker_highlight_group = ''
      " Include text after begin and end markers
      let g:conflict_marker_begin = '^<<<<<<< .*$'
      let g:conflict_marker_end   = '^>>>>>>> .*$'

      highlight ConflictMarkerBegin guibg=#2f7366
      highlight ConflictMarkerOurs guibg=#2e5049
      highlight ConflictMarkerTheirs guibg=#344f69
      highlight ConflictMarkerEnd guibg=#2f628e
      highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
		]])
    end,
  },
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
    cmd = {
      "Gdiffsplit",
      "Git",
      "Gvdiffsplit",
    },
  },
  {
    "sindrets/diffview.nvim",
    event = { "VeryLazy" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
  },
}
