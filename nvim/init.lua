vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- local colors = require("config.colors")
-- colors.setup()
-- vim.cmd("colorscheme minimal")

require("config.winbar")
require("config.initial")
require("config.autocmd")
require("config.command")
require("config.filetype")
require("config.keymaps")
require("config.options")
require("config.plugins")

