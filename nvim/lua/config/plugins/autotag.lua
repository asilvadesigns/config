---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require("nvim-ts-autotag").setup({
    opts = {
      -- Defaults
      enable_close = false, -- Auto close tags
      enable_close_on_slash = true, -- Auto close on trailing </
      enable_rename = true, -- Auto rename pairs of tags
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
      ["html"] = {
        enable_close = false,
      },
    },
  })
end

return M
