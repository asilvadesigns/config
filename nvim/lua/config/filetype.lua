vim.filetype.add({
  extension = {
    env = "sh",
    mdx = "markdown",
    templ = "templ",
  },
  filename = {
    [".envrc"] = "sh",
    ["go.mod"] = "gomod",
    ["go.sum"] = "gosum",
  },
  pattern = {
    [".env%..*"] = "sh",
  },
})
