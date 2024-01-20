return {
  "mrjones2014/smart-splits.nvim",
  event = { "VeryLazy" },
  config = function()
    require("smart-splits").setup({})

    -- resize
    vim.keymap.set("n", "<S-Down>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<S-Left>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<S-Right>", require("smart-splits").resize_right)
    vim.keymap.set("n", "<S-Up>", require("smart-splits").resize_up)

    -- moving
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- swapping
    vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
  end,
}
