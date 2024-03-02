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

vim.api.nvim_create_augroup("status_and_winbar", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  group = "status_and_winbar",
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

-- vim.api.nvim_create_autocmd({
--   "BufEnter",
--   "CursorMoved",
--   "CursorMovedI",
--   "FileChangedShellPost",
--   "Filetype",
--   "ModeChanged",
--   "SessionLoadPost",
--   "VimResized",
--   "WinEnter",
-- }, {
--   group = "status_and_winbar",
--   callback = function()
--     local value = " "
--
--     -- local git_ready = vim.fn.system("git rev-parse --is-inside-work-tree")
--     -- git_ready = string.gsub(git_ready, "%s+", "")
--     --
--     -- if git_ready == "true" then
--     --   local branch = vim.fn.system("git symbolic-ref --short HEAD 2>/dev/null")
--     --   if vim.v.shell_error == 0 then
--     --     branch = string.gsub(branch, "%s+", "")
--     --     value = "  " .. branch
--     --   end
--     -- end
--
--     local lsp_ready = vim.lsp.buf.server_ready()
--
--     if lsp_ready then
--       local diagnostics = vim.diagnostic.get(0)
--
--       local error_count = 0
--       local warning_count = 0
--       local information_count = 0
--       local hint_count = 0
--
--       for _, diagnostic in ipairs(diagnostics) do
--         if diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
--           error_count = error_count + 1
--         elseif diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Warning then
--           warning_count = warning_count + 1
--         elseif diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Information then
--           information_count = information_count + 1
--         elseif diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Hint then
--           hint_count = hint_count + 1
--         end
--       end
--
--       -- Format diagnostics for display in the statusline
--       local diagnostic_string = ""
--       if error_count > 0 then
--         diagnostic_string = diagnostic_string .. "Errors: " .. error_count .. " "
--       end
--       if warning_count > 0 then
--         diagnostic_string = diagnostic_string .. "Warnings: " .. warning_count .. " "
--       end
--       if information_count > 0 then
--         diagnostic_string = diagnostic_string .. "Info: " .. information_count .. " "
--       end
--       if hint_count > 0 then
--         diagnostic_string = diagnostic_string .. "Hints: " .. hint_count .. " "
--       end
--
--       -- Update the value for the statusline
--       if diagnostic_string ~= "" then
--         value = value .. " | " .. diagnostic_string
--       else
--         value = value .. " | no diagnostics"
--       end
--     end
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
