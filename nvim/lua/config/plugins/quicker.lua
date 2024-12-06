local M = {}

M.setup = function()
  require("quicker").setup({
    keys = {
      {
        ">",
        function()
          vim.notify("so...")
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          vim.notify("so...")
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },
  })
end

return M
