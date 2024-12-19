local M = {}

M.setup = function()
  local function file_to_qf(selected)
    local qf_list = {}
    for i = 1, #selected do
      local file = require("fzf-lua.path").entry_to_file(selected[i])
      local text = file.stripped:match(":%d+:%d?%d?%d?%d?:?(.*)$")
      table.insert(qf_list, {
        bufnr = file.bufnr,
        col = file.col,
        lnum = file.line > 0 and file.line or 1,
        filename = file.bufname or file.path or file.uri,
        text = text or file.stripped,
      })
    end
    table.sort(qf_list, function(a, b)
      if a.filename == b.filename then
        if a.lnum == b.lnum then
          return math.max(0, a.col) < math.max(0, b.col)
        else
          return math.max(0, a.lnum) < math.max(0, b.lnum)
        end
      else
        return a.filename < b.filename
      end
    end)
    vim.fn.setqflist(qf_list)
    vim.fn.setqflist({}, "a", { title = "qf list" })
    vim.cmd("botright copen")
  end

  local function str_to_qf(selected)
    vim.notify("WTF")
    local qf_list = {}
    for i = 1, #selected do
      local text = selected[i]
      vim.print("what..." .. text)
      -- local file = require("fzf-lua.path").entry_to_file(selected[i])
      -- local text = file.stripped:match(":%d+:%d?%d?%d?%d?:?(.*)$")
      table.insert(qf_list, {
        bufnr = nil,
        col = nil,
        lnum = nil,
        filename = text,
        text = text,
      })
    end
    table.sort(qf_list, function(a, b)
      if a.filename == b.filename then
        if a.lnum == b.lnum then
          return math.max(0, a.col) < math.max(0, b.col)
        else
          return math.max(0, a.lnum) < math.max(0, b.lnum)
        end
      else
        return a.filename < b.filename
      end
    end)
    vim.fn.setqflist(qf_list)
    vim.fn.setqflist({}, "a", { title = "qf list" })
    vim.cmd("botright copen")
  end

  require("fzf-lua").setup({
    winopts = {
      height = 0.60, -- window height
      width = 0.60, -- window width
      row = 0.50, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      backdrop = 100,
    },
    keymap = {
      builtin = {
        ["ctrl-q"] = "select-all+accept",
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    commands = {
      previewer = false,
    },
    files = {
      previewer = false,
      actions = { ["default"] = file_to_qf },
    },
    highlights = {
      previewer = true,
      actions = { ["default"] = str_to_qf },
    },
    oldfiles = {
      previewer = false,
      actions = { ["default"] = file_to_qf },
    },
    blines = {
      previewer = false,
    },
    lsp = {
      previewer = false,
    },
  })

  require("fzf-lua").register_ui_select()
end

return M
