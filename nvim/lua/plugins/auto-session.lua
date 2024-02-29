return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    require("auto-session").setup({
      log_level = "error",
      session_lens = {
        load_on_setup = false,
      },
    })
  end,
}
