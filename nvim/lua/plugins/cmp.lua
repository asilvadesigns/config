return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    -- Snippet Engine
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- LSP completion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    -- LSP kind
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local kind_icons = {
      Class = "󰠱",
      Color = "󰏘",
      Constant = "󰏿",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "󰇽",
      File = "󰈙",
      Folder = "󰉋",
      Function = "󰊕",
      Interface = "",
      Keyword = "󰌋",
      Method = "󰆧",
      Module = "",
      Operator = "󰆕",
      Property = "󰜢",
      Reference = "",
      Snippet = "",
      Struct = "",
      Text = "",
      TypeParameter = "󰅲",
      Unit = "",
      Value = "󰎠",
      Variable = "󰀫",
    }

    luasnip.config.setup()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
      formatting = {
        format = function(entry, vim_item)
          local lspkind_ok, lspkind = pcall(require, "lspkind")
          if not lspkind_ok then
            -- From kind_icons array
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              luasnip = "[LuaSnip]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
            })[entry.source.name]
            return vim_item
          else
            -- From lspkind
            return lspkind.cmp_format()(entry, vim_item)
          end
        end,
      },
    })
  end,
}
