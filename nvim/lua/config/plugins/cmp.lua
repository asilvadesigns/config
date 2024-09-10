local M = {}

M.setup = function()
  local cmp = require("cmp")
  local compare = require("cmp.config.compare")
  local luasnip = require("luasnip")

  luasnip.config.setup()

  -- completion = {
  --   autocomplete = false,
  --   completeopt = "menu,menuone,noselect",
  -- },
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- Select the [n]ext item
      ["<C-n>"] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      -- Scroll the documentation window [b]ack / [f]orward
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- Manually trigger c[o]mpletion
      ["<C-o>"] = cmp.mapping.complete(),
      -- Move to right in snippet expansion
      -- ["<C-l>"] = cmp.mapping(function()
      --   if luasnip.expand_or_locally_jumpable() then
      --     luasnip.expand_or_jump()
      --   end
      -- end, { "i", "s" }),
      -- -- Move to left in snippet expansion
      -- ["<C-h>"] = cmp.mapping(function()
      --   if luasnip.locally_jumpable(-1) then
      --     luasnip.jump(-1)
      --   end
      -- end, { "i", "s" }),
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
      { name = "lazydev", group_index = 0, priority_weight = 90 },
      {
        name = "buffer",
        keyword_length = 5,
        max_view_entries = 5,
        priority_weight = 70,
        option = {
          get_bufnrs = function()
            local buf = vim.api.nvim_get_current_buf()
            local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
            if byte_size > 1024 * 1024 then -- 1 megabyte max
              return {}
            end
            return { buf }
          end,
          indexing_interval = 1000,
          keyword_length = 5,
        },
      },
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
    -- formatting = {
    --   expandable_indicator = true,
    --   fields = { "kind", "abbr", "menu" },
    --   -- format = require("lspkind").cmp_format({
    --   --   maxwidth = 50,
    --   --   with_text = false,
    --   -- }),
    -- },
  })

  -- cmp.setup.cmdline({ "/", "?" }, {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = "buffer" },
  --   },
  -- })
end

return M
