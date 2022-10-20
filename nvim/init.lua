-- require('impatient')
local modules = {
  'core.autocmd',
  'core.keymaps',
  'core.options',
  'core.plugins',
}

for k,v in pairs(modules) do
  package.loaded[v] = Nil
  require(v)
end
