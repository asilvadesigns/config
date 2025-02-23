---@diagnostic disable: missing-fields
local M = {}

_G.config_is_completion_enabled = false
_G.state_did_init = false -- NOTE: _G.config_is_completion_enabled won't work if enabled was not previously called, no idea why.
_G.state_is_cmdline_mode = false
_G.state_should_disable_after_insert_leave = false

M.setup = function()
  vim.api.nvim_create_user_command("ToggleCompletion", function()
    _G.config_is_completion_enabled = not _G.config_is_completion_enabled
  end, {})

  vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = function()
      _G.state_is_cmdline_mode = true
    end,
  })

  vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
      _G.state_is_cmdline_mode = false
    end,
  })

  --- NOTE: assuming I only want completion on demand if generally disabled
  vim.keymap.set("i", "<C-y>", function()
    if not _G.config_is_completion_enabled then
      _G.config_is_completion_enabled = true
      _G.state_should_disable_after_insert_leave = true
      vim.schedule(function()
        require("blink.cmp").show()
      end)
    end
  end, {})

  local yolo = vim.api.nvim_create_augroup("smdh", { clear = true })
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = yolo,
    callback = function()
      if _G.state_should_disable_after_insert_leave then
        _G.config_is_completion_enabled = false
        _G.state_should_disable_after_insert_leave = false
      end
    end,
  })

  require("blink.cmp").setup({
    enabled = function()
      if not _G.state_did_init then
        _G.state_did_init = true
        return true
      end

      if _G.state_is_cmdline_mode then
        return true
      end

      return vim.bo.buftype ~= "prompt" and _G.config_is_completion_enabled
    end,
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
    },
    cmdline = {
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        --
        ["<Down>"] = { "show", "select_next", "fallback" },
        ["<Tab>"] = { "show", "select_next", "fallback" },
        --
        ["<Up>"] = { "select_prev", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          auto_insert = function(ctx)
            return ctx.mode == "cmdline"
          end,
        },
      },
      menu = {
        border = "rounded",
        draw = {
          columns = { { "kind_icon", gap = 1 }, { "label", "label_description" } },
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      -- default = { "lsp", "path", "snippets", "buffer" },
      default = { "lsp", "path", "buffer" },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
        },
      },
    },
  })

  vim.cmd("hi! link BlinkCmpDocBorder FloatBorder")
  vim.cmd("hi! link BlinkCmpMenuBorder FloatBorder")
  vim.cmd("hi! link BlinkCmpSignatureHelpBorder FloatBorder")
  vim.cmd("hi! link BlinkCmpMenu NormalFloat")
end

return M
