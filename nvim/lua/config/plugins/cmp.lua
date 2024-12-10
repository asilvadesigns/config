local M = {}

M.setup = function()
  local cmp = require("cmp")
  local compare = require("cmp.config.compare")
  local luasnip = require("luasnip")

  luasnip.config.setup()

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    window = {
      documentation = cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
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
    sources = cmp.config.sources({
      { name = "path", priority_weight = 110 },
      { name = "nvim_lsp", max_view_entries = 20, priority_weight = 100 },
      { name = "lazydev", group_index = 0, priority_weight = 90 }, -- folke/lazydev.nvim
      { name = "buffer", keyword_length = 5 },
    }),
    sorting = {
      priority_weight = 1.0,
      comparators = {
        compare.locality,
        compare.recently_used,
        compare.length,
        compare.exact,
        compare.kind,
        compare.score,
        compare.order,
      },
    },
    experimental = {
      ghost_text = false,
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

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })

  -- cmp.setup.cmdline({ "/", "?" }, {
  --   sources = {
  --     { name = "buffer" },
  --   },
  -- })
end

return M
