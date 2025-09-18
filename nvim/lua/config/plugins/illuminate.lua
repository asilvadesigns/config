local M = {}

M.setup = function()
  require("illuminate").configure({
    filetypes_denylist = {
      "NvimTree",
      "fugitiveblame",
      "fyler",
      "grug-far",
      "markdown",
      "oil",
    },
    modes_allowlist = { "n" },
    delay = 50,
    min_count_to_highlight = 2,
  })

  vim.api.nvim_create_user_command("ToggleIlluminate", function()
    _G.show_illuminate = not _G.show_illuminate
    if _G.show_illuminate then
      require("illuminate").resume()
    else
      require("illuminate").pause()
    end
  end, {})
end

return M
