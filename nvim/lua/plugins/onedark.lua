return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        lualine = {
          transparent = true,
        },
        highlights = {
          -- common
          FoldColumn = { fg = "$fg", bg = "$bg0" },
          SignColumn = { fg = "$fg", bg = "$bg0" },
          -- neotree
          NeoTreeEndOfBuffer = { fg = "$bg0", bg = "$bg0" },
          NeoTreeNormal = { bg = "$bg0" },
          NeoTreeNormalNC = { bg = "$bg0" },
          NeoTreeNormalVertSplit = { fg = "$bg0", bg = "$bg0" },
          -- NeoTreeVertSplit = { fg = "$bg0", bg = "$bg0" },
          NeoTreeWinSeparator = { fg = "$bg2", bg = "$bg0" },
          -- lualine
          StatusLine = { fg = "$fg", bg = "$bg0" },
          StatusLineTerm = { fg = "$fg", bg = "$bg0" },
          StatusLineNC = { fg = "$grey", bg = "$bg0" },
          StatusLineTermNC = { fg = "$grey", bg = "$bg0" },
        },
      })

      vim.cmd("colorscheme onedark")
    end,
  },
}