---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("fyler").setup({
    icon_provider = "nvim_web_devicons",
    git_status = false,
    views = {
      explorer = {
        width = 0.8,
        height = 0.8,
        kind = "float",
        border = "rounded",
        git_status = false,
      },
    },
    win = {
      win_opts = {
        number = false,
        relativenumber = false,
      },
    },
  })

  vim.keymap.set("n", "<leader>x", ":Fyler<CR>", {
    desc = "Show Fyler",
    silent = true,
  })
end

return M
