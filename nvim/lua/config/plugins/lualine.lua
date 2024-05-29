local M = {}

M.setup = function()
  local colors = require("catppuccin.palettes").get_palette()

  local function get_filename(color)
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

  local function get_diagnostics(color, colored)
    local square = vim.fn.nr2char(0x25aa)

    return {
      {
        "diagnostics",
        always_visible = false,
        color = color,
        colored = colored,
        symbols = { error = square, warn = square, info = square, hint = square },
        on_click = function()
          vim.cmd("Trouble")
        end,
      },
    }
  end

  local function get_branch(git_color)
    return {
      {
        "branch",
        icon = "",
        color = git_color,
        on_click = function()
          vim.cmd("Git")
        end,
      },
      -- {
      --   "filename",
      --   color = git_color,
      --   file_status = true, -- Displays file status (readonly status, modified status)
      --   newfile_status = false, -- Display new file status (new file means no write after created)
      --   path = 3,
      --   shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      --   symbols = {
      --     modified = "[+]", -- Text to show when the file is modified.
      --     readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
      --     unnamed = "[No Name]", -- Text to show for unnamed buffers.
      --     newfile = "[New]", -- Text to show for newly created file before first write
      --   },
      -- },
    }
  end

  local function file_details(color)
    return {
      { "location", color = color },
      { "progress", color = color },
      { "encoding", color = color },
      { "filetype", color = color, colored = false },
    }
  end

  require("lualine").setup({
    extensions = { "oil" },
    options = {
      component_separators = " ",
      disabled_filetypes = {
        statusline = { "trouble", "oil" },
        winbar = { "NvimTree", "Outline", "no-neck-pain", "trouble" },
      },
      globalstatus = true,
      icons_enabled = true,
      section_separators = "",
      theme = {
        normal = {
          a = { bg = colors.base },
          b = { bg = colors.base },
          c = { bg = colors.base },
          z = { bg = colors.base },
        },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = get_branch({ fg = colors.surface2 }),
      lualine_x = {},
      lualine_y = {},
      lualine_z = file_details({ fg = colors.surface2 }),
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = get_filename({ bg = colors.base, fg = colors.surface2 }),
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}, -- get_diagnostics(nil, true),
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = get_filename({ bg = colors.base, fg = colors.surface2 }),
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}, --get_diagnostics({ bg = colors.base, fg = colors.surface2 }, false),
    },
  })
end

return M
