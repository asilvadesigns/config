--- @param value string
local function print_and_copy(value)
  vim.cmd("call setreg('+', '" .. vim.fn.escape(value, "'") .. "')")
  print("Copied: " .. value)
end

vim.api.nvim_create_user_command("CopyFiletype", function()
  print_and_copy(vim.bo.filetype)
end, {})

vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  print_and_copy(vim.fn.expand("%:~p"))
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  print_and_copy(vim.fn.fnamemodify(vim.fn.expand("%"), ":~:."))
end, {})

vim.api.nvim_create_user_command("CopySelection", function()
  local old_reg = vim.fn.getreg("v")
  vim.api.nvim_exec('normal! gv"vy', false)

  local raw_search = vim.fn.getreg("v")
  vim.fn.setreg("v", old_reg)

  local text = vim.fn.escape(raw_search, "/\\.*$^~[]")
  vim.cmd("normal! /\\<" .. text .. "\\>\r")
end, {})

vim.keymap.set("v", "<c-s>", ":<C-U>CopySelection<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("RenameFile", function()
  local old_path = vim.fn.expand("%:p:h") .. "/"
  local old_name = vim.fn.expand("%:t")

  vim.ui.input({
    prompt = "New name: ",
    default = old_name,
  }, function(new_name)
    if new_name == nil or new_name == old_name then
      return
    end

    if not new_name:match("%.[^.]+$") then
      print("Must provide a file extension!")
      return
    end

    local old = old_path .. old_name
    local new = old_path .. new_name

    local success, err = os.rename(old, new)

    if not success then
      print("Could not update!", err)
      return
    end


    vim.cmd("e! " .. new)
  end)
end, {})
