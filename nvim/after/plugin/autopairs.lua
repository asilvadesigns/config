local ok, autopairs = pcall(require, 'autopairs')
if (not ok) then return end

autopairs().setup()
