local modules = {
  'albertos.keymaps',
  'albertos.options',
  'albertos.plugins',
}

for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
