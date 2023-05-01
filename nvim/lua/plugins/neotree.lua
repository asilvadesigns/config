return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.keymap.set('n', '<leader>j', '<CMD>NeoTreeReveal<CR>', { noremap = true, desc = 'reveal file in explorer'})
    end
  }
}
