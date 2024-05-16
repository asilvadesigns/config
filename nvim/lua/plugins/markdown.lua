return {
  "iamcco/markdown-preview.nvim",
  enabled = true,
  cmd = {
    "MarkdownPreview",
    "MarkdownPreviewStop",
    "MarkdownPreviewToggle",
  },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
