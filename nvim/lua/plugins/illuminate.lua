return {
  "RRethy/vim-illuminate",
  event = { "VeryLazy" },
  enabled = false,
  config = function()
    require("illuminate").configure({
      filetypes_denylist = { "NvimTree", "oil" },
      large_file_cutoff = 5000, -- disable at 5k lines.
    })
  end,
}
