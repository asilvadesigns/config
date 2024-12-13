local M = {}

M.setup = function()
  local neoscroll = require("neoscroll")

  neoscroll.setup({
    mappings = {},
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

  local modes = {
    "n",
    "v",
    "x",
  }

  vim.keymap.set(modes, "<leader>u", function()
    neoscroll.ctrl_u({ duration = 50, easing = "sine" })
  end, { desc = "Scroll Up" })

  vim.keymap.set(modes, "<C-u>", function()
    neoscroll.ctrl_u({ duration = 50, easing = "sine" })
  end, { desc = "Scroll Up" })

  vim.keymap.set(modes, "<leader>d", function()
    neoscroll.ctrl_d({ duration = 50, easing = "sine" })
  end, { desc = "Scroll Down" })

  vim.keymap.set(modes, "<C-d>", function()
    neoscroll.ctrl_d({ duration = 50, easing = "sine" })
  end, { desc = "Scroll Down" })

  local keymap = {
    -- full page up
    ["<C-b>"] = function()
      neoscroll.ctrl_b({ duration = 450, easing = "sine" })
    end,
    -- full page down
    ["<C-f>"] = function()
      neoscroll.ctrl_f({ duration = 450, easing = "sine" })
    end,
    -- line down
    -- ["<C-y>"] = function()
    --   neoscroll.scroll(-0.1, { move_cursor = false, duration = 100, easing = "sine" })
    -- end,
    -- line up
    -- ["<C-e>"] = function()
    --   neoscroll.scroll(0.1, { move_cursor = false, duration = 100, easing = "sine" })
    -- end,
    -- scroll top
    ["zt"] = function()
      neoscroll.zt({ half_win_duration = 50, easing = "sine" })
    end,
    -- scroll middle
    ["zz"] = function()
      neoscroll.zz({ half_win_duration = 50, easing = "sine" })
    end,
    ["z."] = function()
      neoscroll.zz({ half_win_duration = 50, easing = "sine" })
    end,
    -- scroll bottom
    ["zb"] = function()
      neoscroll.zb({ half_win_duration = 50, easing = "sine" })
    end,
  }

  for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
  end
end

return M
