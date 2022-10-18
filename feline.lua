local utils = require('core.utils')
local feline = utils.get_plugin('feline')

if not feline then return end

feline.setup({
  components = {
    active = {
      left = {
        fileinfo = {
          provider = {
            name = "file_info",
            opts = {
              type = "relative-short",
            },
          },
          hl = {
            style = "bold",
          },
          left_sep = " ",
          right_sep = " ",
        },
      }
    },
    inactive = {},
  }
})
