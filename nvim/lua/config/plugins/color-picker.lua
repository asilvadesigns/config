local M = {}

-- NOTE: was having fun with some logic but you can only toggle this globally, so useless.
-- local whitelist = { ["css"] = true, ["json"] = true }
-- local ignore = {
--   [""] = true,
--   ["fzflua"] = true,
--   ["noice"] = true,
--   ["snacks_dashboard"] = true,
--   ["telescope"] = true,
-- }
--
-- ---@param stage string
-- ---@param buf_id integer
-- ---@return boolean
-- local function should_enable(stage, buf_id)
--   local filetype = vim.bo[buf_id].filetype
--
--   if ignore[filetype] then
--     return false
--   end
--
--   if whitelist[filetype] then
--     vim.notify(stage .. "::enabling color picker!" .. "FT::" .. filetype)
--     require("oklch-color-picker.highlight").enable()
--   else
--     vim.notify(stage .. "::disabling color picker!" .. "FT::" .. filetype)
--     require("oklch-color-picker.highlight").disable()
--   end
--
--   return whitelist[filetype]
-- end

M.setup = function()
  -- local buf_id = vim.api.nvim_win_get_buf(0)
  ---@diagnostic disable-next-line: missing-fields
  require("oklch-color-picker").setup({
    highlight = {
      style = "virtual_left",
      enabled = true, --should_enable("INIT", buf_id),
    },
  })

  vim.api.nvim_create_user_command("ColorPickerToggle", function()
    require("oklch-color-picker.highlight").toggle()
  end, {})

  -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  --   pattern = "*",
  --   callback = function(args)
  --     should_enable("AUTOCMD", args.buf)
  --   end,
  -- })
end

return M
