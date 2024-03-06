-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({
  "FocusGained",
  "TermClose",
  "TermLeave",
}, { command = "checktime" })

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- -- cursorline for active buffers
-- vim.api.nvim_create_autocmd("WinEnter", {
--   callback = function()
--     vim.cmd("setlocal cursorline")
--   end,
-- })
--
-- -- no cursor for inactive buffers
-- vim.api.nvim_create_autocmd("WinLeave", {
--   callback = function()
--     vim.cmd("setlocal nocursorline")
--   end,
-- })

-- -- show numbers in help
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "help",
--   command = "setlocal number",
-- })

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

local cached_status_line = ""

local winbar_exclude_filetypes = {
  "NvimTree",
  "Outline",
  "TelescopePrompt",
  "Trouble",
  "alpha",
  "dashboard",
  "help",
  "lir",
  "neogitstatus",
  "packer",
  "qf",
  "spectre_panel",
  "startify",
  "toggleterm",
}

local function renderWinbar()
  local win_config = vim.api.nvim_win_get_config(0)
  local win_filetype = vim.bo.filetype

  if win_config.relative ~= "" or win_filetype == "telescope" then
    return
  end

  if vim.tbl_contains(winbar_exclude_filetypes, win_filetype) then
    vim.opt_local.winbar = nil
    return
  end

  local sep = "  "
  local name = vim.fn.expand("%:t")
  local path = " " .. string.gsub(vim.fn.expand("%:~:.:h"), "/", sep) .. sep
  local value = "%#Comment#" .. path .. name .. "%*"

  return value
end

local function lsp()
  local count = {
    Error = 0,
    Hint = 0,
    Info = 0,
    Warn = 0,
  }

  local signs = {
    Error = "󰅚 ",
    Hint = "󰌶 ",
    Info = " ",
    Warn = "󰀪 ",
  }

  local levels = {
    errors = "Error",
    hints = "Hint",
    info = "Info",
    warnings = "Warn",
  }

  for _, level in pairs(levels) do
    count[level] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = signs["Error"] .. count["Error"] .. " "
  local hints = signs["Hint"] .. count["Hint"] .. " "
  local info = signs["Info"] .. count["Info"] .. " "
  local warnings = signs["Warn"] .. count["Warn"] .. " "

  return errors .. warnings .. hints .. info
end

local function renderStatusLine()
  local is_excluded = vim.tbl_contains(winbar_exclude_filetypes, vim.bo.filetype)
  local is_floating = vim.api.nvim_win_get_config(0).relative ~= ""

  if is_excluded or is_floating then
    return cached_status_line
  end

  local value = " "

  local git_info = vim.b.gitsigns_status_dict
  if git_info ~= nil and git_info.head ~= "" then
    value = "  " .. git_info.head .. "  "
  end

  local lsp_info = lsp()
  if lsp_info ~= "" then
    value = value .. "  " .. lsp_info
  end

  cached_status_line = value
  return cached_status_line
end

vim.api.nvim_create_augroup("winbar", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  group = "winbar",
  callback = function()
    local winbar = renderWinbar()
    vim.api.nvim_set_option_value("winbar", winbar, { scope = "local" })
  end,
})

-- local timer = vim.loop.new_timer()
--
-- timer:start(
--   0, -- initial delay
--   500, -- 1000 / 500 === 2fps
--   vim.schedule_wrap(function()
--     vim.schedule(function()
--       -- local status_line = renderStatusLine()
--       -- if cached_status_line ~= status_line then
--       --   vim.api.nvim_set_option_value("statusline", status_line, {})
--       -- end
--
--       local winbar = renderWinbar()
--       if cached_winbar ~= winbar then
--         vim.api.nvim_set_option_value("winbar", winbar, { scope = "local" })
--       end
--     end)
--   end)
-- )

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
vim.api.nvim_create_augroup("auto_read", { clear = true })

vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})
