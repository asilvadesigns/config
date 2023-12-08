-- quickly get filetype
vim.api.nvim_create_user_command('GetFiletype', function()
  print("Filetype is ::'" .. vim.bo.filetype .. "'")
end, {})
