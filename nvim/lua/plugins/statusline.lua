return {
  {
    'rebelot/heirline.nvim',
    enabled = true,
    event = { 'UIEnter' },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local icons = require('config.options').icons

      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local DiagnosticsBlock = {
        -- condition = conditions.has_diagnostics,

        static = {
          error_icon = icons.error,
          hint_icon = icons.hint,
          info_icon = icons.info,
          warn_icon = icons.warn,
        },

        init = function(self)
          -- instead of nil, can use 0 for current buffer
          self.errors = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN })
          self.hints = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.HINT })
          self.info = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.INFO })
        end,

        update = { "DiagnosticChanged", "BufEnter" },

        on_click = {
          callback = function()
            require("trouble").toggle({ mode = "document_diagnostics" })
            -- or
            -- vim.diagnostic.setqflist()
          end,
          name = "heirline_diagnostics",
        },
        -- Error
        {
          provider = function(self)
            return ("  " .. self.error_icon)
          end,
          hl = "DiagnosticError",
        },
        {
          provider = function(self)
            return (" " .. self.errors .. " ")
          end,
          hl = "Comment",
        },
        -- Warnings
        {
          provider = function(self)
            return self.warn_icon
          end,
          hl = "DiagnosticWarn",
        },
        {
          provider = function(self)
            return (" " .. self.warnings .. " ")
          end,
          hl = "Comment",
        },
        -- Info
        {
          provider = function(self)
            return self.info_icon
          end,
          hl = "DiagnosticInfo",
        },
        {
          provider = function(self)
            return (" " .. self.info .. " ")
          end,
          hl = "Comment",
        },
        -- Hints
        {
          provider = function(self)
            return self.hint_icon
          end,
          hl = "DiagnosticHint",
        },
        {
          provider = function(self)
            return (" " .. self.hints .. " ")
          end,
          hl = "Comment",
        },
      }

      local FileNameBlock = {
        -- let's first set up some attributes needed by this component and it's children
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
      }

      local FileIcon = {
        init = function(self)
          local filename = self.filename
          local extension = vim.fn.fnamemodify(filename, ":e")
          self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
            { default = true })
        end,
        provider = function(self)
          return self.icon and ("  " .. self.icon .. " ")
        end,
        hl = function(self)
          return { fg = self.icon_color }
        end
      }

      local FileName = {
        provider = function(self)
          -- first, trim the pattern relative to the current directory. For other
          -- options, see :h filename-modifers
          local filename = vim.fn.fnamemodify(self.filename, ":.")
          if filename == "" then return "[No Name]" end
          -- now, if the filename would occupy more than 1/4th of the available
          -- space, we trim the file path to its initials
          -- See Flexible Components section below for dynamic truncation
          if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
          end
          return filename
        end,
        -- hl = { fg = utils.get_highlight("Directory").fg },
      }

      local FileFlags = {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = "[+]",
          -- hl = { fg = "green" },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "",
          -- hl = { fg = "orange" },
        },
      }

      -- Now, let's say that we want the filename color to change if the buffer is
      -- modified. Of course, we could do that directly using the FileName.hl field,
      -- but we'll see how easy it is to alter existing components using a "modifier"
      -- component
      local FileNameModifer = {
        hl = function()
          if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force = true }
          end
        end,
      }
      -- NOTE: use with...
      utils.insert(FileNameModifer, FileName) -- a new table where FileName is a child of FileNameModifier

      FileNameBlock = utils.insert(FileNameBlock,
        FileIcon,
        FileName, -- a new table where FileName is a child of FileNameModifier
        FileFlags,
        { provider = '%<' }-- this means that the statusline is cut here when there's not enough space
      )

      require('heirline').setup({
        statusline = {
          DiagnosticsBlock
        },
        winbar = {
          FileNameBlock
        },
        opts = {
          -- if the callback returns true, the winbar will be disabled for that window
          -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { "nofile", "prompt", "help", "quickfix" },
              filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
            }, args.buf)
          end,
        },
      })
    end
  },
  {
    'feline-nvim/feline.nvim',
    enabled = false,
    event = { 'VeryLazy' },
    config = function()
      require('feline').winbar.setup({
        components = {
          active = {
            {
              provider = {
                name = 'file_info',
                opts = {
                  type = 'full-path'
                }
              },
            }
          },
          inactive = {
            {
              provider = {
                name = 'file_info',
                opts = {
                  type = 'full-path'
                }
              },
            }
          },
        }
      })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    event = { 'VeryLazy' },
    config = function()
      require('lualine').setup({
        options = {
          always_divide_middle = true,
          component_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = {}, winbar = { 'NvimTree' } },
          globalstatus = true,
          icons_enabled = true,
          ignore_focus = {},
          refresh = { statusline = 100, tabline = 100, winbar = 100 },
          section_separators = { left = '', right = '' },
          theme = 'auto',
        },
        extensions = {
          'fugitive',
          'trouble',
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            {
              'diagnostics',
              color = { bg = 'none' },
              always_visible = true,
              symbols = {
                error = '',
                hint = '',
                info = '',
                warn = '',
              },
            }
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {
          lualine_a = {},
          lualine_b = {
            {
              'filename',
              color = { bg = 'none' },
              path = 3,
            }
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {},
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {
            {
              'filename',
              color = 'CursorLineNr',
              path = 3,
            }
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "utilyre/barbecue.nvim",
    enabled = false,
    event = { 'VeryLazy' },
    name = "barbecue",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false, -- prevent barbecue from updating itself automatically
        symbols = {
          separator = "",
        }
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "WinResized",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end
  }
}
