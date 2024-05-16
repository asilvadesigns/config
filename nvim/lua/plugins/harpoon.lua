return {
  "ThePrimeagen/harpoon",
  enabled = false,
  event = { "VeryLazy" },
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local conf = require("telescope.config").values
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.api.nvim_create_user_command("HarpoonOpen", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {})

    vim.api.nvim_create_user_command("HarpoonAdd", function()
      harpoon:list():add()
    end, {})

    vim.api.nvim_create_user_command("HarpoonNext", function()
      harpoon:list():next()
    end, {})

    vim.api.nvim_create_user_command("HarpoonPrev", function()
      harpoon:list():prev()
    end, {})

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<C-e>", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
}
