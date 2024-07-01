local M = {}

M.setup = function()
  local cmp = require("cmp")
  local compare = require("cmp.config.compare")
  local luasnip = require("luasnip")

  -- require("cmp-npm").setup({
  --   ignore = {},
  --   only_semantic_versions = false,
  --   only_latest_version = false,
  -- })

  luasnip.config.setup()

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noselect",
    },
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
    sources = cmp.config.sources({
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      -- { name = "luasnip" },
      { name = "lazydev" },
    }, {
      { name = "path" },
      -- { name = "buffer" },
    }),
    sorting = {
      priority_weight = 1.0,
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,

        -- copied from cmp-under, but I don't think I need the plugin for this.
        -- I might add some more of my own.
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find("^_+")
          local _, entry2_under = entry2.completion_item.label:find("^_+")
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,

        compare.kind,
        compare.sort_text,
        compare.length,
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

  -- cmp.setup.cmdline({ "/", "?" }, {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = "buffer" },
  --   },
  -- })
end

return M
