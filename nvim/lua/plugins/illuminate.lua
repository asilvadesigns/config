return {
  "RRethy/vim-illuminate",
  enabled = false,
  event = "VeryLazy" ,
  config = function()
    require("illuminate").configure({
      filetypes_denylist = {
        "NvimTree",
        "oil",
        "spectre_panel",
        "trouble",
      },
      large_file_cutoff = 5000, -- disable at 5k lines.
    })
  end,
}
