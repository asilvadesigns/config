local M = {}

M.setup = function()
  require("auto-session").setup({
    session_lens = {
      load_on_setup = false,
    },
  })
end

return M
