local keys = vim.keymap.set

local ok, leap = pcall(require, 'leap')
if (not ok) then return end

leap.set_default_keymaps()
keys('n', ';', '<CMD>lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<CR>')
