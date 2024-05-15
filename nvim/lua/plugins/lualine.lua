local function filenameIcon(color, colored)
  return {
    {
      "filetype",
      color = color,
      colored = colored, -- Displays filetype icon in color if set to true
      icon_only = true, -- Display only an icon for filetype
      icon = { align = "right" }, -- Display filetype icon on the right hand side
    },
  }
end

local function filenameText(color, colored)
  return {
    -- {
    --   "filetype",
    --   colored = colored, -- Displays filetype icon in color if set to true
    --   icon_only = true, -- Display only an icon for filetype
    --   icon = { align = "right" }, -- Display filetype icon on the right hand side
    -- },
    {
      "filename",
      color = color,
      file_status = true, -- Displays file status (readonly status, modified status)
      newfile_status = false, -- Display new file status (new file means no write after created)
      path = 3,
      shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      symbols = {
        modified = "[+]", -- Text to show when the file is modified.
        readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "[No Name]", -- Text to show for unnamed buffers.
        newfile = "[New]", -- Text to show for newly created file before first write
      },
    },
  }
end

local function get_diagnostics(color)
  return {
    {
      "diagnostics",
      color = color,
      always_visible = true,
      colored = false, -- Displays diagnostics status in color if set to true.
      on_click = function()
        vim.cmd("Trouble")
      end,
    },
  }
end
--
--   local icons = {
--     Error = { icon = "󰅚" },
--     Hint = { icon = "󰌶" },
--     Info = { icon = "" },
--     Warn = { icon = "󰀪" },
--   }
--
--   local label = {}
--
--   for severity, data in pairs(icons) do
--     local n = vim.diagnostic.get(0, { severity = vim.diagnostic.severity[string.upper(severity)] })
--     if n > 0 then
--       table.insert(label, { data.icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
--     end
--   end
--
--   local output = table.concat(label, " ")
--
--   vim.print(vim.inspect(label))
--   vim.print("\n")
--   vim.print(vim.inspect(output))
--
--   -- return [[hello world]]
--   return { output }
-- end

-- local function get_diagnostics(component)
--   return function()
--     local diagnostics = component()
--     local filtered_diagnostics = {}
--     for _, diag in ipairs(diagnostics) do
--       if diag.content ~= "0" then -- Check if diagnostic value is not zero
--         table.insert(filtered_diagnostics, diag)
--       end
--     end
--     return filtered_diagnostics
--   end
-- end

local function gitBranch(color)
  return {
    {
      "branch",
      icon = "",
      color = color,
      on_click = function()
        vim.cmd("Git")
      end,
    },
  }
end

return {
  "nvim-lualine/lualine.nvim",
  event = { "VeryLazy" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

    require("lualine").setup({
      extensions = { "oil" },
      options = {
        component_separators = " ",
        disabled_filetypes = {
          statusline = { "trouble" },
          winbar = { "NvimTree", "no-neck-pain", "trouble" },
        },
        globalstatus = true,
        icons_enabled = true,
        section_separators = "",
        theme = {
          normal = {
            a = { bg = colors.base },
            b = { bg = colors.base },
            c = { bg = colors.base },
          },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = gitBranch({ fg = colors.surface2 }),
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = gitBranch(),
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = filenameText({ fg = colors.surface2 }, true),
        lualine_x = {},
        lualine_y = {},
        lualine_z = get_diagnostics({ fg = colors.surface2 }),
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = filenameText({ fg = colors.surface2 }, false),
        lualine_x = {},
        lualine_y = {},
        lualine_z = get_diagnostics({ fg = colors.surface2 }),
      },
    })
  end,
}
