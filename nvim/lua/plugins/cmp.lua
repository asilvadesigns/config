return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter" ,
  dependencies = {
    -- Snippet Engine
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- LSP completion
    "David-Kunz/cmp-npm",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    -- LSP kind
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("cmp-npm").setup({
      ignore = {},
      only_semantic_versions = false,
      only_latest_version = false,
    })

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
        ["<C-o>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
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
        -- { name = "buffer" },
        -- { name = "npm" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        -- { name = "nvim_lua" },
        { name = "path" },
      },
      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = require("lspkind").cmp_format({
          maxwidth = 50,
          with_text = false,
        }),
      },
    })
  end,
}
