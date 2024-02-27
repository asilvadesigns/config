vim.api.nvim_create_user_command("GetFiletype", function()
  print("Filetype is ::'" .. vim.bo.filetype .. "'")
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  vim.cmd("call setreg('+', expand('%'))")
end, {})

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

    local success, err = os.rename(old_path .. old_name, old_path .. new_name)

    if not success then
      print("Could not update!", err)
      return
    end

    vim.cmd("e " .. new_name)
  end)
end, {})
