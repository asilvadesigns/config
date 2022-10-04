local ok, tree = pcall(require, 'nvim-tree')
if (not ok) then return end

tree.setup({
  git = {
    enable = true,
    ignore = false
  },
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    ignore_list = {},
    update_cwd = true,
  },
  view = { width = 40 },
})
