---@diagnostic disable: missing-fields

_G.grug_instance = "grug-instance"
_G.cursorline_enabled = false

local show_invisible_chars = true
local use_alternate_directory = false

local root = vim.fn.stdpath("data")
if use_alternate_directory then
  root = vim.fn.expand("~/dev")
end

local snacks = root .. "/lazy/snacks.nvim"
local lazypath = root .. "/lazy/lazy.nvim"

if vim.env.PROF then
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = { event = "VimEnter" },
  })
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.cmdheight = 0
vim.opt.cursorline = _G.cursorline_enabled
vim.opt.diffopt = "internal,filler,closeoff,linematch:60"
vim.opt.expandtab = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] --   ||   ||  
vim.opt.foldcolumn = "0" -- "0" to hide folds. "1" to show.
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.guicursor =
  "n-v-c:blocki,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait500-blinkoff250-blinkon250,sm:block-blinkwait500-blinkoff250-blinkon250"
vim.opt.ignorecase = true
vim.opt.list = show_invisible_chars
vim.opt.listchars = "tab:  ,nbsp:+,trail:·,extends:,precedes:" -- space:·,tab:»·, NOTE: tab must have 2 characters
vim.opt.redrawtime = 1500
vim.opt.scrolloff = 1
vim.opt.sessionoptions = "buffers,curdir,winsize,winpos"
vim.opt.shiftwidth = 2
vim.opt.showbreak = "↳  " -- slow on huge linebreaks for some reason
vim.opt.signcolumn = "yes"
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.showtabline = 1
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.synmaxcol = 256
vim.opt.tabstop = 2
vim.opt.updatetime = 100
vim.opt.wrap = false

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono"
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  -- vim.g.neovide_scroll_animation_length = 0.05
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
  -- TODO: at some point add hotkeys for modifying font size.
end

---
--- Keymaps
---
vim.keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Clear highlight" })

vim.keymap.set("i", "<c-l>", "<ESC>A", { desc = "Go to end of line" })
vim.keymap.set("i", "<c-h>", "<ESC>I", { desc = "Go to start of line" })

vim.keymap.set("n", "z1", "<CMD>setlocal foldlevel=0<CR>", { desc = "Fold level 1" })
vim.keymap.set("n", "z2", "<CMD>setlocal foldlevel=1<CR>", { desc = "Fold level 2" })
vim.keymap.set("n", "z3", "<CMD>setlocal foldlevel=2<CR>", { desc = "Fold level 3" })
vim.keymap.set("n", "z4", "<CMD>setlocal foldlevel=3<CR>", { desc = "Fold level 4" })
vim.keymap.set("n", "z0", "<CMD>setlocal foldlevel=99<CR>", { desc = "Reset fold level" })

vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>")

vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Focus bottom window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Focus top window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Focus right window" })

vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close this window" })

vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })

vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Go to the left window" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Go to the down window" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Go to the up window" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Go to the right window" })

vim.keymap.set("n", "<leader>d", "<C-d>", { desc = "Scroll down" })
vim.keymap.set("n", "<leader>u", "<C-u>", { desc = "Scroll up" })

vim.keymap.set("n", "<leader>s", function()
  vim.cmd("w")
end, { desc = "Save" })

vim.keymap.set("n", "<leader>qf", function()
  if vim.bo.filetype == "NvimTree" then
    require("nvim-tree.api").tree.close()
  end

  if vim.bo.filetype == "oil" then
    require("oil").close()
  end

  vim.cmd("qa!")
end, { desc = "Save and Quit" })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<", ":tabprevious<CR>", { desc = "Go to the previous tab" })
vim.keymap.set("n", ">", ":tabnext<CR>", { desc = "Go to the next tab" })
vim.keymap.set("n", "tl", ":tablast<CR>", { desc = "Go to the last tab" })
vim.keymap.set("n", "tn", ":tabnew<CR>", { desc = "Create new tab" })
vim.keymap.set("n", "to", ":tabonly<CR>", { desc = "Close other tabs" })
vim.keymap.set("n", "tq", ":tabclose<CR>", { desc = "Close this tab" })

vim.keymap.set("n", "<leader>1", ":tabn 1<CR>", { desc = "Go to tab 1" })
vim.keymap.set("n", "<leader>2", ":tabn 2<CR>", { desc = "Go to tab 2" })
vim.keymap.set("n", "<leader>3", ":tabn 3<CR>", { desc = "Go to tab 3" })
vim.keymap.set("n", "<leader>4", ":tabn 4<CR>", { desc = "Go to tab 4" })
vim.keymap.set("n", "<leader>5", ":tabn 5<CR>", { desc = "Go to tab 5" })
vim.keymap.set("n", "<leader>6", ":tabn 6<CR>", { desc = "Go to tab 6" })
vim.keymap.set("n", "<leader>7", ":tabn 7<CR>", { desc = "Go to tab 7" })
vim.keymap.set("n", "<leader>8", ":tabn 8<CR>", { desc = "Go to tab 8" })
vim.keymap.set("n", "<leader>9", ":tabn 9<CR>", { desc = "Go to tab 9" })

vim.keymap.set("v", "<Tab>", ">gv", { desc = "Add indent" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Remove indent " })
-- vim.keymap.set("v", "p", '"_dP', { desc="Paste" })

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-c>", [[<C-\><C-n>]])

-- @see: https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "ge", vim.diagnostic.open_float, {
  desc = "Open diagnostic message",
})

local signs = require("config.signs")

for type, icon in pairs(signs.diagnostics) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
  })
end

vim.diagnostic.config({
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ", --signs.icons.square,
      [vim.diagnostic.severity.HINT] = " ", --signs.icons.square,
      [vim.diagnostic.severity.INFO] = " ", --signs.icons.square,
      [vim.diagnostic.severity.WARN] = " ", --signs.icons.square,
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    },
  },
  underline = true,
  virtual_text = false,
  virtual_lines = false,
})

vim.filetype.add({
  extension = {
    env = "sh",
    gleam = "gleam",
    mdx = "mdx",
    templ = "templ",
  },
  filename = {
    [".envrc"] = "sh",
    ["go.mod"] = "gomod",
    ["go.sum"] = "gosum",
  },
  pattern = {
    [".env%..*"] = "sh",
  },
})

require("lazy").setup({
  root = root .. "/lazy/plugins",
  spec = {
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    {
      "folke/snacks.nvim",
      lazy = false,
      config = require("config.plugins.snacks").setup,
    },
    {
      "folke/trouble.nvim",
      cmd = { "ToggleTrouble", "Trouble" },
      config = require("config.plugins.trouble").setup,
    },
    {
      "folke/ts-comments.nvim",
      event = "VeryLazy",
      opts = {},
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    {
      "rmagatti/auto-session",
      cmd = { "SessionRestore" },
      config = require("config.plugins.auto-session").setup,
    },
    {
      "catppuccin/nvim",
      lazy = false,
      name = "catppuccin",
      config = require("config.plugins.catppuccin").setup,
    },
    {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      config = require("config.plugins.quicker").setup,
    },
    {
      "eero-lehtinen/oklch-color-picker.nvim",
      version = "*",
      event = "User SuperLazy",
      config = require("config.plugins.color-picker").setup,
    },
    {
      "lewis6991/satellite.nvim",
      event = "User SuperLazy",
      config = require("config.plugins.satellite").setup,
    },
    {
      "petertriho/nvim-scrollbar",
      enabled = false,
      event = "User SuperLazy",
      config = require("config.plugins.scrollbar").setup,
    },
    {
      "stevearc/conform.nvim",
      cmd = { "Format", "FormatWithBiome", "FormatWithLsp", "FormatWithPrettier" },
      keys = { { "<leader>m", "<CMD>Format<CR>", desc = "Format" } },
      config = require("config.plugins.conform").setup,
    },
    {
      "stevearc/oil.nvim",
      event = "User SuperLazy",
      config = require("config.plugins.oil").setup,
    },
    {
      "axelvc/template-string.nvim",
      ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      opts = {},
    },
    {
      "gbprod/substitute.nvim",
      keys = { { "X", "<CMD>lua require('substitute.exchange').visual()<CR>", mode = "x" } },
      opts = {},
    },
    {
      "kylechui/nvim-surround",
      keys = { { "S", mode = "v" }, { "cs" }, { "ds" }, { "ys" } },
      opts = {},
    },
    {
      "windwp/nvim-autopairs",
      enabled = false,
      event = "InsertEnter",
      opts = {},
    },
    {
      "windwp/nvim-ts-autotag",
      enabled = false,
      event = "User SuperLazy",
      opts = {
        enable_close = false,
        enable_close_on_slash = true,
        enable_rename = true,
      },
    },
    {
      "shortcuts/no-neck-pain.nvim",
      keys = { { "<leader>z", "<CMD>NoNeckPain<CR>", desc = "Toggle zen mode" } },
      version = "*",
      config = require("config.plugins.no-neck-pain").setup,
    },
    {
      "nvim-tree/nvim-tree.lua",
      event = "User SuperLazy",
      config = require("config.plugins.nvim-tree").setup,
    },
    {
      "mvllow/modes.nvim",
      enabled = false,
      tag = "v0.2.1",
      event = "User SuperLazy",
      config = require("config.plugins.modes").setup,
    },
    {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
      dependencies = {
        "b0o/schemastore.nvim",
        "williamboman/mason.nvim",
      },
      config = require("config.plugins.lsp").setup,
    },
    {
      "saghen/blink.cmp",
      version = "*",
      event = { "CmdlineEnter", "InsertEnter" },
      opts_extend = { "sources.default" },
      dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
      config = require("config.plugins.blink").setup,
    },
    {
      "MagicDuck/grug-far.nvim",
      event = "User SuperLazy",
      cmd = { "GrugFar", "GrugFarLocal", "GrugFarGlobal" },
      keys = {
        {
          "f",
          mode = "v",
          --- TODO: write logic to handle searching within the grug-far instance...
          function()
            local grugfar = require("grug-far")
            local options = {
              instanceName = _G.grug_instance,
              prefills = {
                paths = vim.fn.expand("%"),
                search = grugfar.get_current_visual_selection(),
              },
            }
            if grugfar.has_instance(options.instanceName) then
              grugfar.get_instance(options.instanceName):update_input_values(options.prefills, false)
              grugfar.get_instance(options.instanceName):open()
            else
              grugfar.toggle_instance(options)
            end
          end,
          desc = "Find selected in file",
        },
        {
          "F",
          mode = "v",
          function()
            local grugfar = require("grug-far")
            local options = {
              instanceName = _G.grug_instance,
              prefills = {
                paths = "",
                search = grugfar.get_current_visual_selection(),
              },
            }
            if grugfar.has_instance(options.instanceName) then
              grugfar.get_instance(options.instanceName):update_input_values(options.prefills, false)
              grugfar.get_instance(options.instanceName):open()
            else
              grugfar.toggle_instance(options)
            end
          end,
          desc = "Find selected in project",
        },
        {
          "<C-S>",
          function()
            local grugfar = require("grug-far")
            local options = {
              instanceName = _G.grug_instance,
              prefills = {
                paths = "",
                search = "",
              },
            }
            if grugfar.has_instance(options.instanceName) then
              grugfar.get_instance(options.instanceName):update_input_values(options.prefills, false)
              grugfar.get_instance(options.instanceName):open()
            else
              grugfar.toggle_instance(options)
            end
          end,
          desc = "Find in project",
        },
        {
          "<C-F>",
          function()
            local grugfar = require("grug-far")
            local options = {
              instanceName = _G.grug_instance,
              prefills = {
                paths = vim.fn.expand("%"),
                search = "",
              },
            }
            if grugfar.has_instance(options.instanceName) then
              grugfar.get_instance(options.instanceName):update_input_values(options.prefills, false)
              grugfar.get_instance(options.instanceName):open()
            else
              grugfar.toggle_instance(options)
            end
          end,
          desc = "Find in file",
        },
      },
      config = require("config.plugins.grug-far").setup,
    },
    {
      "ggandor/leap.nvim",
      keys = {
        {
          "s",
          function()
            require("leap").leap({
              target_windows = require("leap.user").get_focusable_windows(),
            })
          end,
        },
        {
          "gs",
          function()
            require("leap.remote").action()
          end,
        },
      },
      config = function()
        require("leap").opts.safe_labels = {}
        require("leap").opts.highlight_unlabeled_phase_one_targets = true
        vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "NonText" }) -- darken everything
        vim.api.nvim_set_hl(0, "LeapLabel", { link = "DiagnosticVirtualTextInfo" }) -- darken everything
      end,
    },
    {
      "Wansmer/treesj",
      keys = {
        { "<leader>tj", ":TSJJoin<CR>", silent = true, desc = "Join TS nodes" },
        { "<leader>tm", ":TSJToggle<CR>", silent = true, desc = "Toggle TS nodes" },
        { "<leader>ts", ":TSJSplit<CR>", silent = true, desc = "Split TS nodes" },
      },
      opts = {},
    },
    {
      "NeogitOrg/neogit",
      event = "User SuperLazy",
      dependencies = { "sindrets/diffview.nvim" },
      config = require("config.plugins.neogit").setup,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "User SuperLazy",
      config = require("config.plugins.gitsigns").setup,
    },
    {
      "mrjones2014/smart-splits.nvim",
      keys = {
        -- stylua: ignore start
        { "<C-h>", function() require('smart-splits').move_cursor_left() end, desc = "Move cursor left" },
        { "<C-j>", function() require('smart-splits').move_cursor_down() end, desc = "Move cursor down" },
        { "<C-k>", function() require('smart-splits').move_cursor_up() end, desc = "Move cursor up" },
        { "<C-l>", function() require('smart-splits').move_cursor_right() end, desc = "Move cursor right" },
        -- stylua: ignore end
      },
      config = require("config.plugins.smart-splits").setup,
    },
    {
      "jake-stewart/multicursor.nvim",
      event = "VeryLazy",
      branch = "1.0",
      config = require("config.plugins.multicursor").setup,
    },
    {
      "wurli/visimatch.nvim",
      keys = { "V", "v" },
      opts = { hl_group = "WVisiMatch", chars_lower_limit = 3 },
    },
    {
      "RRethy/vim-illuminate",
      enabled = false,
      event = "User SuperLazy",
      config = require("config.plugins.illuminate").setup,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      build = ":TSUpdate",
      config = require("config.plugins.treesitter").setup,
    },
    {
      "andymass/vim-matchup",
      event = "User SuperLazy",
      config = require("config.plugins.matchup").config,
    },
    {
      "kevinhwang91/nvim-ufo",
      event = "User TreesitterReady",
      dependencies = { "kevinhwang91/promise-async" },
      config = require("config.plugins.ufo").setup,
    },
    {
      "monaqa/dial.nvim",
      event = "User SuperLazy",
      config = require("config.plugins.dial").setup,
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "editorconfig",
        "getscriptPlugin",
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "osc52",
        "remotePlugin",
        "rplugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimballPlugin",
        "zipPlugin",
      },
    },
  },
  ui = {
    backdrop = 100,
    border = "rounded",
  },
})
require("config.lastplace")
require("config.tabbar")
require("config.winbar")

---
--- Autocmds
---
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("reload-file-static", { clear = true }),
  desc = "Reload buffer on focus",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--   group = vim.api.nvim_create_augroup("reload-file-dyanmic", { clear = true }),
--   desc = "Reload buffer on focus",
--   callback = debounce(function()
--     if vim.fn.getcmdwintype() == "" then
--       vim.cmd("checktime")
--     end
--   end, 1000),
-- })

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("vim-resized", { clear = true }),
  desc = "Resset buffer size on window resize",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  desc = "Highlight yanked lines",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("user-lazy-done", { clear = true }),
  desc = "Custom lazy load autocmd",
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "SuperLazy" })
    end, 200)
  end,
})


---
--- Commands
---
--- @param value string
local function print_and_copy(value)
  vim.cmd("call setreg('+', '" .. vim.fn.escape(value, "'") .. "')")
  print("Copied: " .. value)
end

vim.api.nvim_create_user_command("BufOnly", function()
  vim.cmd("%bdelete|edit #|normal`")
end, {})

vim.api.nvim_create_user_command("CopyFiletype", function()
  print_and_copy(vim.bo.filetype)
end, {})

vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  print_and_copy(vim.fn.expand("%:~p"))
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  print_and_copy(vim.fn.fnamemodify(vim.fn.expand("%"), ":~:."))
end, {})

vim.api.nvim_create_user_command("CopyHighlightGroup", function()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")

  local captures = vim.treesitter.get_captures_at_pos(0, line - 1, col - 1)
  if #captures > 0 then
    vim.notify("treesitter::")
    print_and_copy(captures[#captures].capture)
    return
  end

  local synID = vim.fn.synID(line, col, 1)
  local synName = vim.fn.synIDattr(synID, "name")
  vim.notify("OG colors::")
  print_and_copy(synName)
end, {})

vim.api.nvim_create_user_command("ToggleDiagnosticText", function()
  local config = vim.diagnostic.config()
  if config ~= nil then
    vim.diagnostic.config({ virtual_text = not config.virtual_text })
  end
end, {})

vim.api.nvim_create_user_command("ToggleInvisibleChars", function()
  show_invisible_chars = not show_invisible_chars
  vim.opt.list = show_invisible_chars
end, {})

vim.api.nvim_create_user_command("ToggleCursorLine", function()
  _G.cursorline_enabled = not _G.cursorline_enabled
  vim.opt.cursorline = _G.cursorline_enabled
end, {})

