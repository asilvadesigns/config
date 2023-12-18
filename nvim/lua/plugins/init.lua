return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {},
    config = function()
      require("neodev").setup()

      local lsp_servers = {
        lua_ls = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
          },
        },
        angularls = {},
        cssls = {},
        tsserver = {},
      }

      local lsp_on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<c-.>", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap(
          "gr",
          require("telescope.builtin").lsp_references,
          "[G]oto [R]eferences"
        )
        -- utils.nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        -- -- See `:help K` for why this keymap
        -- -- Lesser used LSP functionality
        -- utils.nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- utils.nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end

      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      lsp_capabilities =
        require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(lsp_servers),
        automatic_installation = true,
      })

      -- name::prismals
      -- name::cssls
      -- name::lua_ls
      -- name::jsonls
      -- name::yamlls
      -- name::html
      -- name::pyright
      -- name::tsserver
      -- name::angularls
      -- name::eslint

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = lsp_capabilities,
            on_attach = lsp_on_attach,
            settings = lsp_servers[server_name],
          })
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

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
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = {
      "SymbolsOutline",
      "SymbolsOutlineOpen",
    },
    keys = {
      {
        "<leader>s",
        "<cmd>SymbolsOutline<cr>",
        desc = "Symbols outline",
      },
    },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    keys = {
      {
        "<leader>j",
        "<CMD>NeoTreeReveal<CR>",
        desc = "reveal file in explorer",
      },
      {
        "<leader>x",
        "<CMD>Neotree position=current reveal_file=%:p<CR>",
        desc = "reveal file in current buffer",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({
        enable_diagnostics = true,
        enable_git_status = false,
        enable_modified_markers = false,
        buffers = {
          follow_current_file = false,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = false,
          renderers = {
            file = {
              { "indent" },
              { "name" },
            },
          },
        },
        default_component_configs = {
          indent = {
            indent_marker = "│",
            indent_size = 2,
            last_indent_marker = "└",
            with_markers = true,
          },
          icon = {
            folder_closed = "",
            folder_open = "",
          },
        },
        use_default_mappings = false,
        window = {
          mappings = {
            -- operations
            ["<cr>"] = "open",
            ["<space>"] = "toggle_node",
            ["A"] = "add_directory",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
            -- movements
            ["<bs>"] = "navigate_up",
            -- searching
            ["#"] = "fuzzy_sorter",
            ["<c-x>"] = "clear_filter",
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            -- splits
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- toggle
            ["H"] = "toggle_hidden",
            ["R"] = "refresh",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "VeryLazy" },
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "prisma",
        "python",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    enabled = false,
    event = { "VeryLazy" },
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, opts)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, opts)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, opts)
      vim.keymap.set(
        "n",
        "<C-\\>",
        nvim_tmux_nav.NvimTmuxNavigateLastActive,
        opts
      )
      vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, opts)
    end,
  },
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    event = { "VeryLazy" },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
}
