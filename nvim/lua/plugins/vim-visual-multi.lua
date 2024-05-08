return {
  "mg979/vim-visual-multi",
  event = { "VeryLazy" },
  config = function()
    vim.g.VM_default_mappings = 1
    vim.g.VM_mouse_mappings = 0
    vim.g.VM_set_statusline = 0
    vim.g.VM_show_warnings = 0
    vim.g.VM_silent_exit = 1

    vim.keymap.set("x", "A", "<Plug>(VM-Visual-Cursors)", {})
  end,
}
