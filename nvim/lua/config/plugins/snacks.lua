local M = {}

M.setup = function()
  require("snacks").setup({
    ---@class snacks.indent.Config
    indent = {
      enabled = false,
      only_current = true,
      scope = {
        enabled = false,
        animate = { enabled = false },
      },
      chunk = {
        enabled = false,
        animate = { enabled = false },
      },
    },
    ---@class snacks.bigfile.Config
    bigfile = {
      enabled = true,
      notify = true,
      size = 1 * 1024 * 1024, -- 1.0MB
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        -- vim.cmd([[NoMatchParen]])
        ---@diagnostic disable-next-line: missing-fields
        Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
        -- vim.b.minianimate_disable = true
        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
        end)
      end,
    },
    ---@class snacks.dashboard.Config
    dashboard = {
      enabled = true,
      sections = {
        { key = "s", padding = 1, desc = "Session Restore", action = ":SessionRestore" },
        { key = "a", padding = 1, desc = "Actions", action = ":CommandPalette" },
        { key = "f", padding = 1, desc = "Find File", action = ":FzfLua files" }, --:Telescope find_files
        { key = "e", padding = 1, desc = "Recent Files", action = ":FzfLua oldfiles" }, --:Telescope oldfiles
        { key = "l", padding = 1, desc = "Lazy", action = ":Lazy" },
        { key = "m", padding = 1, desc = "Mason", action = ":Mason" },
        { key = "q", padding = 1, desc = "Quit", action = ":qa!" },
        { section = "startup" },
      },
    },
    ---@class snacks.statuscolumn.Config
    statuscolumn = {
      enabled = true,
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

vim.cmd("hi! link SnacksIndent WinSeparator")

return M
