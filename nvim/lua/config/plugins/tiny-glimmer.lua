local M = {}

M.setup = function()
  require("tiny-glimmer").setup({
    overwrite = {
      paste = { enabled = true },
      redo = { enabled = true },
      search = { enabled = true },
      undo = { enabled = true },
      yank = { enabled = true },
    },
    support = {
      substitute = { enabled = true },
    },
  })
end

return M
