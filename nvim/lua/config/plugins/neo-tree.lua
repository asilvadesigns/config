local M = {}

M.setup = function()
  require("neo-tree").setup({
    enable_git_status = false,
  })

  -- Neotree position=current dir=%:p:h:h reveal_file=%:p
  vim.keymap.set("n", "<leader>j", function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd("Neotree close")
    else
      vim.cmd("Neotree reveal_file=%:p")
    end
    --   local current_file = vim.fn.expand("%:p")
    --   local cwd = vim.fn.getcwd()
    --
    --   if vim.fn.filereadable(current_file) == 1 and string.sub(current_file, 1, #cwd) == cwd then
    --     vim.cmd("NvimTreeFindFile")
    --     vim.cmd("normal! zz")
    --   else
    --     vim.cmd("NvimTreeOpen")
    --   end
    -- end
  end, { desc = "Open file in file tree" })
end

return M
