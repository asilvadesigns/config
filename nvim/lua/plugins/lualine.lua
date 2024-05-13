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

local function filenameText(color)
  return {
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
    {
      "diagnostics",
      color = color,
      always_visible = true,
      colored = false,           -- Displays diagnostics status in color if set to true.
      on_click = function()
        vim.cmd("Trouble")
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
          statusline = { "" },
          -- winbar = { "" },
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
        lualine_x = filenameText({ fg = colors.surface2 }),
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = gitBranch(),
        lualine_x = filenameText(),
        lualine_y = {},
        lualine_z = {},
      },
      -- winbar = {},
      -- inactive_winbar = {},
    })
  end,
}
