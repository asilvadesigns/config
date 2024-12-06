local M = {}

M.setup = function()
  require("dashboard").setup({
    theme = "doom",
    config = {
      center = {
        { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
        { icon = " ", key = "e", desc = "Recent Files", action = ":Telescope oldfiles" },
        { icon = " ", key = "s", desc = "Load Session", action = ":SessionRestore" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
  })
end

return M
