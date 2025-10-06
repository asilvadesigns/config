---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("fyler").setup({
    icon_provider = "nvim_web_devicons",
    git_status = {
      enabled = false,
    },
    win = {
      kind = "replace",
      border = "rounded",
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

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "Fyler",
    callback = function(event)
      -- local opts = { buffer = event.buf, silent = true, noremap = true }
      local opts = { buffer = event.buf, silent = true }

      vim.keymap.set("n", "<C-o>", "q", opts)
      -- vim.keymap.set("n", "<C-o>", function()
      --   vim.notify("yooo")
      -- end, opts)
    end,
  })
end

return M
