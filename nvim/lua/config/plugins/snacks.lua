local M = {}

M.setup = function()
  require("snacks").setup({
    ---@class snacks.dashboard.Config
    dashboard = {
      sections = {
        {
          key = "s",
          padding = 1,
          desc = "Session Restore",
          action = ":SessionRestore",
        },
        {
          key = "a",
          padding = 1,
          desc = "Actions",
          action = ":CommandPalette",
        },
        {
          key = "f",
          padding = 1,
          desc = "Find File",
          action = ":Telescope find_files",
        },
        {
          key = "e",
          padding = 1,
          desc = "Recent Files",
          action = ":Telescope oldfiles",
        },
        {
          key = "l",
          padding = 1,
          desc = "Lazy",
          action = ":Lazy",
        },
        {
          key = "m",
          padding = 1,
          desc = "Mason",
          action = ":Mason",
        },
        {
          key = "q",
          padding = 1,
          desc = "Quit",
          action = ":qa!",
        },
        { section = "startup" },
      },
    },
    ---@class snacks.statuscolumn.Config
    statuscolumn = {
      -- "sign"
      left = { "git", "mark" }, -- priority of signs on the left (high to low)
      right = { "fold" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    ---@class snacks.scroll.Config
    -- scroll = {
    --   animate = {
    --     duration = { step = 15, total = 75 }, --5 && 125 is good
    --     easing = "inOutSine",
    --   },
    --   spamming = 10, -- threshold for spamming detection
    --   -- what buffers to animate
    --   filter = function(buf)
    --     return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
    --   end,
    -- },
  })
end

return M
