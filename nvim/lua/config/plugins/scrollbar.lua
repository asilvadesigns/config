---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  --- TODO: will need to update to handle color changes...
  local colors = require("catppuccin.palettes").get_palette("frappe")

  require("scrollbar").setup({
    show = _G.show_scrollbar,
    set_highlights = true,
    marks = {
      Cursor = {
        text = "—",
        priority = 0,
        gui = nil,
        color = colors.sky,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = "Normal",
      },
      Search = { color = colors.green },
      Error = { color = colors.red },
      Warn = { color = colors.yellow },
      Info = { color = colors.blue },
      Hint = { color = colors.teal },
      Misc = { color = colors.mauve },
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = false,
      handle = true,
      search = true,
      ale = false,
    },
    excluded_filetypes = {
      "DressingInput",
      "NvimTree",
      "TelescopePrompt",
      "cmp_docs",
      "cmp_menu",
      "dropbar_menu",
      "dropbar_menu_fzf",
      "noice",
      "prompt",
    },
  })

  vim.api.nvim_create_user_command("ToggleScrollbar", function()
    _G.show_scrollbar = not _G.show_scrollbar
    require("scrollbar.config").set({ show = _G.show_scrollbar })
    require("scrollbar").render()
  end, {})

  require("scrollbar.handlers.search").setup({
    override_lens = function(render, posList, nearest, idx, relIdx)
      local sfw = vim.v.searchforward == 1
      local indicator, text, chunks
      local absRelIdx = math.abs(relIdx)
      if absRelIdx > 1 then
        indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '' or '')
      elseif absRelIdx == 1 then
        indicator = sfw ~= (relIdx == 1) and '' or ''
      else
        indicator = ''
      end

      local lnum, col = unpack(posList[idx])
      if nearest then
        local cnt = #posList
        if indicator ~= '' then
          text = ('[%s %d/%d]'):format(indicator, idx, cnt)
        else
          text = ('[%d/%d]'):format(idx, cnt)
        end
        chunks = { { ' ' }, { text, 'HlSearchLensNear' } }
      else
        text = ('[%s %d]'):format(indicator, idx)
        chunks = { { ' ' }, { text, 'HlSearchLens' } }
      end

      render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end
  })
end

return M
