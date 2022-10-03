-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/albertos/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/albertos/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/albertos/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/albertos/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/albertos/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["filetype.nvim"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n¾\5\0\0\6\0\"\0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3=\3\v\0025\3\f\0004\4\0\0=\4\r\0035\4\15\0005\5\14\0>\5\1\4=\4\16\0034\4\0\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0034\4\0\0=\4\22\3=\3\23\0025\3\24\0004\4\0\0=\4\r\0034\4\0\0=\4\16\0035\4\26\0005\5\25\0>\5\1\4=\4\17\0035\4\27\0=\4\19\0035\4\28\0=\4\21\0034\4\0\0=\4\22\3=\3\29\0025\3\30\0004\4\0\0=\4\r\0035\4\31\0=\4\16\0035\4 \0=\4\17\0034\4\0\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\22\3=\3!\2B\0\2\1K\0\1\0\rsections\1\2\0\0\a%F\1\4\0\0\vbranch\tdiff\16diagnostics\1\0\0\20inactive_winbar\1\2\0\0\rprogress\1\3\0\0\rencoding\15fileformat\1\3\0\0\0\rfilename\1\2\1\0\rfiletype\14icon_only\2\1\0\0\vwinbar\14lualine_z\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\3\0\0\rencoding\15fileformat\14lualine_c\14lualine_b\1\3\0\0\0\rfilename\1\2\1\0\rfiletype\14icon_only\2\14lualine_a\1\0\0\foptions\1\0\0\frefresh\1\0\3\15statusline\3d\vwinbar\3d\ftabline\3d\23section_separators\1\0\2\nright\5\tleft\5\25component_separators\1\0\1\17globalstatus\2\1\0\2\nright\5\tleft\5\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nÙ\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\3=\3\b\0025\3\t\0=\3\n\2B\0\2\1K\0\1\0\tview\1\0\1\nwidth\3(\24update_focused_file\16ignore_list\1\0\2\15update_cwd\2\venable\2\bgit\1\0\2\15update_cwd\2\20respect_buf_cwd\2\1\0\2\vignore\1\venable\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    config = { "\27LJ\2\n`\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\4\0B\0\1\1K\0\1\0\tload\1\0\1\nstyle\tdark\nsetup\fonedark\frequire\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^plenary"] = "plenary.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nÙ\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\3=\3\b\0025\3\t\0=\3\n\2B\0\2\1K\0\1\0\tview\1\0\1\nwidth\3(\24update_focused_file\16ignore_list\1\0\2\15update_cwd\2\venable\2\bgit\1\0\2\15update_cwd\2\20respect_buf_cwd\2\1\0\2\vignore\1\venable\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n¾\5\0\0\6\0\"\0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3=\3\v\0025\3\f\0004\4\0\0=\4\r\0035\4\15\0005\5\14\0>\5\1\4=\4\16\0034\4\0\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0034\4\0\0=\4\22\3=\3\23\0025\3\24\0004\4\0\0=\4\r\0034\4\0\0=\4\16\0035\4\26\0005\5\25\0>\5\1\4=\4\17\0035\4\27\0=\4\19\0035\4\28\0=\4\21\0034\4\0\0=\4\22\3=\3\29\0025\3\30\0004\4\0\0=\4\r\0035\4\31\0=\4\16\0035\4 \0=\4\17\0034\4\0\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\22\3=\3!\2B\0\2\1K\0\1\0\rsections\1\2\0\0\a%F\1\4\0\0\vbranch\tdiff\16diagnostics\1\0\0\20inactive_winbar\1\2\0\0\rprogress\1\3\0\0\rencoding\15fileformat\1\3\0\0\0\rfilename\1\2\1\0\rfiletype\14icon_only\2\1\0\0\vwinbar\14lualine_z\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\3\0\0\rencoding\15fileformat\14lualine_c\14lualine_b\1\3\0\0\0\rfilename\1\2\1\0\rfiletype\14icon_only\2\14lualine_a\1\0\0\foptions\1\0\0\frefresh\1\0\3\15statusline\3d\vwinbar\3d\ftabline\3d\23section_separators\1\0\2\nright\5\tleft\5\25component_separators\1\0\1\17globalstatus\2\1\0\2\nright\5\tleft\5\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: onedark.nvim
time([[Config for onedark.nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\4\0B\0\1\1K\0\1\0\tload\1\0\1\nstyle\tdark\nsetup\fonedark\frequire\0", "config", "onedark.nvim")
time([[Config for onedark.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
