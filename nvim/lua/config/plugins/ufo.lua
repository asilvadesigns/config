local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: missing-fields
  require("ufo").setup({
    open_fold_hl_timeout = 0,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local totalLines = vim.api.nvim_buf_line_count(0)
      local foldedLines = endLnum - lnum
      local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
      suffix = (" "):rep(rAlignAppndx) .. suffix
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end,
    -- fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    --   local newVirtText = {}
    --   local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    --   local sufWidth = vim.fn.strdisplaywidth(suffix)
    --   local targetWidth = width - sufWidth
    --   local curWidth = 0
    --   for _, chunk in ipairs(virtText) do
    --     local chunkText = chunk[1]
    --     local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    --     if targetWidth > curWidth + chunkWidth then
    --       table.insert(newVirtText, chunk)
    --     else
    --       chunkText = truncate(chunkText, targetWidth - curWidth)
    --       local hlGroup = chunk[2]
    --       table.insert(newVirtText, { chunkText, hlGroup })
    --       chunkWidth = vim.fn.strdisplaywidth(chunkText)
    --       -- str width returned from truncate() may less than 2nd argument, need padding
    --       if curWidth + chunkWidth < targetWidth then
    --         suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
    --       end
    --       break
    --     end
    --     curWidth = curWidth + chunkWidth
    --   end
    --   table.insert(newVirtText, { suffix, "MoreMsg" })
    --   return newVirtText
    -- end,
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  })

  vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

  vim.keymap.set("n", "K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end)
end

return M
