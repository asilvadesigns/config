local M = {}

M.setup = function()
  local neoscroll = require("neoscroll")

  neoscroll.setup({
    easing = "sine",
    pre_hook = function()
      vim.opt.eventignore:append({
        "WinScrolled",
        "CursorMoved",
      })
    end,
    post_hook = function()
      vim.opt.eventignore:remove({
        "WinScrolled",
        "CursorMoved",
      })
    end,
  })

  local keymap = {
    -- up
    ["<leader-u>"] = function()
      neoscroll.ctrl_u({ duration = 125, easing = "sine" })
    end,
    ["<C-u>"] = function()
      neoscroll.ctrl_u({ duration = 125, easing = "sine" })
    end,
    -- down
    ["<C-d>"] = function()
      neoscroll.ctrl_d({ duration = 125, easing = "sine" })
    end,
    ["<leader-d>"] = function()
      neoscroll.ctrl_d({ duration = 125, easing = "sine" })
    end,
    -- full page up
    ["<C-b>"] = function()
      neoscroll.ctrl_b({ duration = 450, easing = "sine" })
    end,
    -- full page down
    ["<C-f>"] = function()
      neoscroll.ctrl_f({ duration = 450, easing = "sine" })
    end,
    -- line down
    ["<C-y>"] = function()
      neoscroll.scroll(-0.1, { move_cursor = false, duration = 100, easing = "sine" })
    end,
    -- line up
    ["<C-e>"] = function()
      neoscroll.scroll(0.1, { move_cursor = false, duration = 100, easing = "sine" })
    end,
    -- scroll top
    ["zt"] = function()
      neoscroll.zt({ half_win_duration = 125, easing = "sine" })
    end,
    -- scroll middle
    ["zz"] = function()
      neoscroll.zz({ half_win_duration = 125, easing = "sine" })
    end,
    -- scroll bottom
    ["zb"] = function()
      neoscroll.zb({ half_win_duration = 125, easing = "sine" })
    end,
  }

  local modes = { "n", "v", "x" }
  for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
  end
end

return M
