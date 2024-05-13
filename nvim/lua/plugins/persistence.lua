return {
  "folke/persistence.nvim",
  event = { "VeryLazy" },
  config = function()
    require("persistence").setup()

    -- if next(vim.fn.argv()) == nil then
    --   require("persistence").load()
    -- end

    vim.api.nvim_create_autocmd("ExitPre", {
      callback = function()
        require("persistence").save()
      end,
    })

    vim.api.nvim_create_user_command("LoadSession", function()
      require("persistence").load()
    end, {})

    vim.api.nvim_create_user_command("SaveSession", function()
      require("persistence").save()
    end, {})
  end,
}
