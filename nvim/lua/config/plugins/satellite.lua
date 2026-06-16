---@diagnostic disable: missing-fields
local M = {}

local excluded_filetypes = {
  "DressingInput",
  "NvimTree",
  "TelescopePrompt",
  "cmp_docs",
  "cmp_menu",
  "dropbar_menu",
  "dropbar_menu_fzf",
  "noice",
  "prompt",
}

local apply_highlights = function()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then
    return
  end

  local flavor = (vim.g.colors_name or ""):match("^catppuccin%-(.+)$") or "frappe"
  local colors = palettes.get_palette(flavor)

  vim.api.nvim_set_hl(0, "SatelliteBar", { bg = colors.surface0 })
  vim.api.nvim_set_hl(0, "SatelliteBackground", {})
  vim.api.nvim_set_hl(0, "SatelliteCursor", { fg = colors.sky })
  vim.api.nvim_set_hl(0, "SatelliteSearch", { fg = colors.green })
  vim.api.nvim_set_hl(0, "SatelliteSearchCurrent", { fg = colors.green, bold = true })
  vim.api.nvim_set_hl(0, "SatelliteDiagnosticError", { fg = colors.red })
  vim.api.nvim_set_hl(0, "SatelliteDiagnosticWarn", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "SatelliteDiagnosticInfo", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "SatelliteDiagnosticHint", { fg = colors.teal })
  vim.api.nvim_set_hl(0, "SatelliteMark", { fg = colors.mauve })
  vim.api.nvim_set_hl(0, "SatelliteQuickfix", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "SatelliteGitSignsAdd", { fg = colors.green })
  vim.api.nvim_set_hl(0, "SatelliteGitSignsChange", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "SatelliteGitSignsDelete", { fg = colors.red })
end

---@param enabled boolean
local set_enabled = function(enabled)
  _G.show_scrollbar = enabled

  if vim.fn.exists(":SatelliteEnable") == 0 then
    local ok, lazy = pcall(require, "lazy")
    if ok then
      lazy.load({ plugins = { "satellite.nvim" } })
    end
  end

  if vim.fn.exists(":SatelliteEnable") == 0 then
    return
  end

  if enabled then
    vim.cmd("silent! SatelliteEnable")
    vim.cmd("silent! SatelliteRefresh")
  else
    vim.cmd("silent! SatelliteDisable")
  end
end

M.toggle = function()
  set_enabled(not _G.show_scrollbar)
end

M.register_commands = function()
  vim.api.nvim_create_user_command("ToggleScrollbar", M.toggle, {})
end

M.setup = function()
  apply_highlights()

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("satellite-highlights", { clear = true }),
    desc = "Refresh Satellite colors",
    callback = apply_highlights,
  })

  require("satellite").setup({
    current_only = false,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = excluded_filetypes,
    width = 2,
    handlers = {
      cursor = {
        enable = true,
        overlap = true,
        priority = 100,
        symbols = { "—" },
      },
      search = {
        enable = true,
        overlap = true,
        priority = 90,
      },
      diagnostic = {
        enable = true,
        overlap = true,
        priority = 80,
        signs = { "-", "=", "≡" },
        min_severity = vim.diagnostic.severity.HINT,
      },
      gitsigns = {
        enable = false,
        overlap = true,
        priority = 70,
        signs = {
          add = "│",
          change = "│",
          delete = "-",
        },
      },
      marks = {
        enable = false,
        overlap = true,
        priority = 60,
        show_builtins = false,
        key = "m",
      },
      quickfix = {
        enable = false,
        overlap = true,
        priority = 50,
        signs = { "-", "=", "≡" },
      },
    },
  })

  M.register_commands()

  vim.api.nvim_create_autocmd({ "TabEnter", "VimResized", "WinEnter", "WinResized" }, {
    group = vim.api.nvim_create_augroup("satellite-refresh", { clear = true }),
    desc = "Refresh Satellite after window changes",
    callback = function()
      if _G.show_scrollbar then
        vim.cmd("silent! SatelliteRefresh")
      end
    end,
  })

  set_enabled(_G.show_scrollbar)
end

return M
