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
      color = color,
      icon = "",
    },
  }
end

return {
  "nvim-lualine/lualine.nvim",
  event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = "|",
        disabled_filetypes = {
          statusline = { "" },
          winbar = { "neo-tree" },
        },
        globalstatus = true,
        icons_enabled = true,
        section_separators = "",
        theme = "auto",
      },
      sections = {
        lualine_a = {},
        lualine_b = gitBranch({ bg = "" }),
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = gitBranch({ bg = "" }),
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_b = filenameIcon({ bg = "" }, true),
        lualine_c = filenameText("Comment"),
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = filenameIcon("Comment", false),
        lualine_c = filenameText("LineNr"),
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
