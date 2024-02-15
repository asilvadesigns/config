return {
  'RRethy/vim-illuminate',
  event = { "BufReadPost", "BufNewFile" },
  config = function ()
    require("illuminate").configure({
      filetypes_denylist = {
        "NvimTree",
        "oil",
      }
    })
  end
}
