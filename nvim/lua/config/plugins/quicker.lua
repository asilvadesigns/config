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
    -- Border characters
    borders = {
      vert = "│",
      -- Strong headers separate results from different files
      strong_header = "─",
      strong_cross = "┼",
      strong_end = "┤",
      -- Soft headers separate results within the same file
      soft_header = "═",
      soft_cross = "╪",
      soft_end = "╡",
    },
  })
end

return M
