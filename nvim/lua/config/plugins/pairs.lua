local M = {}

M.setup = function()
  require("blink.pairs").setup({
    mappings = {
      enabled = _G.enable_auto_pair,
      cmdline = _G.enable_auto_pair,
    },
    highlights = {
      enabled = false,
      cmdline = false,
    },
    matchparen = {
      enabled = true,
      -- cmdline = false,
      -- include_surrounding = true,
      group = "MatchParen",
    },
  })

  local function toggle()
    if _G.enable_auto_pair then
      require("blink.pairs.mappings").enable()
    else
      require("blink.pairs.mappings").disable()
    end
  end

  vim.api.nvim_create_user_command("ToggleAutoPairs", function()
    _G.enable_auto_pair = not _G.enable_auto_pair
    toggle()
  end, {})
end

return M
