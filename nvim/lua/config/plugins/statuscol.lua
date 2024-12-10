local M = {}

M.setup = function()
  local builtin = require("statuscol.builtin")

  require("statuscol").setup({
    relculright = true,
    ft_ignore = {
      "NvimTree",
      "dashboard",
      "snacks_dashboard",
    },
    segments = {
      {
        sign = {
          namespace = { "gitsigns" },
          fillchar = " ", -- │
          maxwidth = 1,
          colwidth = 1,
          wrap = true,
          foldclosed = true,
        },
        click = "v:lua.ScSa",
      },
      { text = { " ", builtin.lnumfunc }, click = "v:lua.ScLa" },
      { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
    },
  })
end

return M
