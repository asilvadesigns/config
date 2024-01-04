return {
  "mg979/vim-visual-multi",
  event = { "VeryLazy" },
  init = function()
    vim.g.VM_default_mappings = 1
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_show_warnings = 1
    vim.g.VM_silent_exit = 0
  end,
}
