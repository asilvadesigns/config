local M = {}

M.setup = function()
  local builtin = require("veil.builtin")

  require("veil").setup({
    sections = {
      builtin.sections.buttons({
        {
          icon = "",
          text = "Load Session",
          shortcut = "s",
          callback = function()
            vim.cmd("SessionRestore")
          end,
        },
        {
          icon = "",
          text = "Actions",
          shortcut = "a",
          callback = function()
            vim.cmd("CommandPalette")
          end,
        },
        {
          icon = "",
          text = "Find Files",
          shortcut = "f",
          callback = function()
            vim.cmd("Telescope find_files")
          end,
        },
        {
          icon = "",
          text = "Old Files",
          shortcut = "e",
          callback = function()
            vim.cmd("Telescope oldfiles")
          end,
        },
        {
          icon = "󰈆",
          text = "Quit",
          shortcut = "q",
          callback = function()
            vim.print("oi!")
            vim.cmd("q")
          end,
        },
      }),
    },
  })
end

return M
