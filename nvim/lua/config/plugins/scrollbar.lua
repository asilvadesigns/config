---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("scrollbar").setup({
    show = _G.show_scrollbar,
    marks = {
      Cursor = {
        text = "—",
        priority = 0,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = "Normal",
      },
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

  ---init
  vim.api.nvim_create_user_command("ToggleScrollbar", function()
    local config = require("scrollbar.config").get()

    if _G.show_scrollbar then
      config.show = false
    else
      config.show = true
    end

    _G.show_scrollbar = not _G.show_scrollbar
    require("scrollbar").render()
  end, {})
end

return M
