local fn = vim.fn

function _G.custom_tabline()
  local tab_count = vim.fn.tabpagenr("$")
  if tab_count < 1 then
    return ""
  end

  local tabline = {}
  for i = 1, tab_count do
    local is_active = (i == fn.tabpagenr())
    local buflist = fn.tabpagebuflist(i)
    local winnr = fn.tabpagewinnr(i)
    local bufname = fn.bufname(buflist[winnr])
    local filename = fn.fnamemodify(bufname, ":t")

    local label = (filename ~= "" and filename or "[No Name]")
    local hl = is_active and "%#TabLineSel#" or "%#TabLine#"

    table.insert(tabline, ("%%%dT%s %s "):format(i, hl, label))
  end

  table.insert(tabline, "%#TabLineFill#")
  return table.concat(tabline)
end

vim.o.tabline = "%!v:lua.custom_tabline()"
