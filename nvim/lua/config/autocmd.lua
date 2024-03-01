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

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

local winbar_exclude_filetypes = {
  "NvimTree",
  "Outline",
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

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  callback = function()
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

    local value = "%#Comment#" .. path .. "%*" .. "%#Bold#" .. name .. "%*"

    vim.api.nvim_set_option_value("winbar", value, { scope = "local" })
  end,
})

-- vim.api.nvim_create_autocmd({ "BufReadPost" }, {
--   callback = function()
--     local value = " ...nothing..."
--
--     -- If the buffer is under Git version control, append the current branch
--     -- if vim.fn.exists(":Git") == 2 and vim.bo.filetype ~= "help" then
--     --   local branch = vim.fn["fugitive#statusline"]()
--     --   if branch ~= "" then
--     --     value = value .. " | Branch: " .. branch
--     --   end
--     -- end
--
--     vim.api.nvim_set_option_value("statusline", value, {})
--   end,
-- })

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
