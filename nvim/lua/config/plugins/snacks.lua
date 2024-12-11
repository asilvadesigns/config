local M = {}

M.setup = function()
  require("snacks").setup({
    dashboard = {
      sections = {
        { key = "s", padding = 1, desc = "Session Restore", action = ":SessionRestore" },
        { key = "a", padding = 1, desc = "Actions", action = ":CommandPalette" },
        { key = "f", padding = 1, desc = "Find File", action = ":Telescope find_files" },
        { key = "e", padding = 1, desc = "Recent Files", action = ":Telescope oldfiles" },
        { key = "l", padding = 1, desc = "Lazy", action = ":Lazy" },
        { key = "m", padding = 1, desc = "Mason", action = ":Mason" },
        { key = "q", padding = 1, desc = "Quit", action = ":qa!" },
        { section = "startup" },
      },
    },
  })
end

return M
