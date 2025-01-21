local M = {}

M.setup = function()
  local plugin = require("smart-splits")

  plugin.setup()

  -- Resize
  vim.keymap.set("n", "<S-Down>", function()
    plugin.resize_down()
  end, { desc = "Resize down" })
  vim.keymap.set("n", "<S-Left>", function()
    plugin.resize_left()
  end, { desc = "Resize left" })
  vim.keymap.set("n", "<S-Right>", function()
    plugin.resize_right()
  end, { desc = "Resize right" })
  vim.keymap.set("n", "<S-Up>", function()
    plugin.resize_up()
  end, { desc = "Resize up" })

  -- Moving
  vim.keymap.set("n", "<C-h>", function()
    plugin.move_cursor_left()
  end, { desc = "Move cursor left" })
  vim.keymap.set("n", "<C-j>", function()
    plugin.move_cursor_down()
  end, { desc = "Move cursor down" })
  vim.keymap.set("n", "<C-k>", function()
    plugin.move_cursor_up()
  end, { desc = "Move cursor up" })
  vim.keymap.set("n", "<C-l>", function()
    plugin.move_cursor_right()
  end, { desc = "Move cursor right" })

  -- Swapping
  vim.keymap.set("n", "<leader><leader>h", function()
    plugin.swap_buf_left()
  end, { desc = "Swap buffer left" })
  vim.keymap.set("n", "<leader><leader>j", function()
    plugin.swap_buf_down()
  end, { desc = "Swap buffer down" })
  vim.keymap.set("n", "<leader><leader>k", function()
    plugin.swap_buf_up()
  end, { desc = "Swap buffer up" })
  vim.keymap.set("n", "<leader><leader>l", function()
    plugin.swap_buf_right()
  end, { desc = "Swap buffer right" })
end

return M
