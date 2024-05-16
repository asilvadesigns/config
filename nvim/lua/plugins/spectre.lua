return {
  "nvim-pack/nvim-spectre",
  enabled = true,
  cmd = { "Spectre" },
  keys = {
    {
      "<c-s>",
      "<cmd>Spectre<cr>",
      desc = "Search",
    },
    {
      "<c-f>",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "Search current file",
    },
  },
  opts = {},
}
