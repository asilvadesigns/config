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
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0\17TroubleClose\18NvimTreeClose\17NeoTreeClose\nonly!\bcmd\bvimp\1\0\5\0\6\0\v3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0004\4\3\0>\0\1\4=\4\5\3B\1\2\1K\0\1\0\18pre_save_cmds\1\0\1\14log_level\nerror\nsetup\17auto-session\frequire\0\0" },
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n \1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0026\3\6\0009\3\a\0039\3\b\3=\3\t\2B\0\2\1K\0\1\0\ftimeout\15timeoutlen\6o\bvim\fmapping\1\2\0\0\akj\1\0\2\tkeys\n<Esc>\22clear_empty_lines\1\nsetup\18better_escape\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n¶\1\0\0\3\0\t\0\0156\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0B\0\2\0016\0\0\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0002highlight! link IndentBlanklineChar VertSplit\bcmd\1\0\1\21show_end_of_line\1\nsetup\21indent_blankline\frequire\tlist\bopt\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\nê\2\0\0\5\0\16\0\0286\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\5\0005\4\6\0B\0\4\0016\0\a\0'\2\b\0B\0\2\0029\0\t\0+\1\2\0=\1\n\0006\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0B\0\4\1K\0\1\0S<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>\6;\6n\bset\vkeymap*highlight_unlabeled_phase_one_targets\topts\tleap\frequire\1\0\3\14nocombine\2\tbold\2\afg\nwhite\14LeapMatch\1\0\1\tlink\17WinSeparator\17LeapBackdrop\16nvim_set_hl\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nJ\0\0\3\1\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0-\2\0\0B\0\2\1K\0\1\0\1À\14goto_prev\23lspsaga.diagnostic\frequireJ\0\0\3\1\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0-\2\0\0B\0\2\1K\0\1\0\1À\14goto_next\23lspsaga.diagnostic\frequireƒ\b\1\0\n\0%\0k5\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\4\6\3B\1\2\0016\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\v\0'\5\f\0\18\6\0\0B\1\5\0016\1\a\0009\1\b\0019\1\t\0015\3\r\0'\4\14\0'\5\15\0\18\6\0\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\16\0'\5\17\0\18\6\0\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\18\0'\5\19\0\18\6\0\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\20\0'\5\21\0\18\6\0\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\22\0'\5\23\0\18\6\0\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\24\0'\5\25\0\18\6\0\0B\1\5\0015\1\29\0006\2\a\0009\2\26\0029\2\27\0029\2\28\2=\2\27\0013\2\30\0003\3\31\0006\4\a\0009\4\b\0049\4\t\4'\6\n\0'\a \0\18\b\2\0\18\t\0\0B\4\5\0016\4\a\0009\4\b\0049\4\t\4'\6\n\0'\a!\0\18\b\3\0\18\t\0\0B\4\5\0016\4\a\0009\4\b\0049\4\t\4'\6\n\0'\a\"\0'\b#\0\18\t\0\0B\4\5\0016\4\a\0009\4\b\0049\4\t\4'\6\n\0'\a\v\0'\b$\0\18\t\0\0B\4\5\0012\0\0€K\0\1\0\31<cmd>Lspsaga hover_doc<CR>\29<cmd>LSoutlineToggle<CR>\ago\a]E\a[E\0\0\1\0\0\nERROR\rseverity\15diagnostic*<cmd>Lspsaga diagnostic_jump_next<CR>\a]e*<cmd>Lspsaga diagnostic_jump_prev<CR>\a[e-<cmd>Lspsaga show_cursor_diagnostics<CR>\age%<cmd>Lspsaga peek_definition<CR>\agD\28<cmd>Lspsaga rename<CR>\15<leader>rn!<cmd>Lspsaga code_action<CR>\n<C-.>\1\3\0\0\6n\6v <cmd>Lspsaga lsp_finder<CR>\agh\6n\bset\vkeymap\bvim\26code_action_lightbulb\1\0\a\16update_time\3–\1\17virtual_text\1\venable\2\18sign_priority\3\20\tsign\2\22cache_code_action\2\21enable_in_insert\1\1\0\2\29code_action_num_shortcut\2\21code_action_icon\bï€\18init_lsp_saga\flspsaga\frequire\1\0\1\vsilent\2\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nû\5\0\0\6\0!\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\16\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0004\5\0\0=\5\a\0045\5\b\0=\5\t\4=\4\n\0034\4\0\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\3=\3\17\0025\3\18\0004\4\0\0=\4\19\0035\4\20\0=\4\21\0034\4\0\0=\4\22\0034\4\0\0=\4\23\0034\4\0\0=\4\24\0034\4\0\0=\4\25\3=\3\26\0025\3\27\0004\4\0\0=\4\19\0034\4\3\0005\5\28\0>\5\1\4=\4\21\0034\4\0\0=\4\22\0034\4\0\0=\4\23\0034\4\0\0=\4\24\0034\4\0\0=\4\25\3=\3\t\0024\3\0\0=\3\29\0025\3\30\0004\4\0\0=\4\19\0034\4\3\0005\5\31\0>\5\1\4=\4\21\0034\4\0\0=\4\22\0034\4\0\0=\4\23\0034\4\0\0=\4\24\0034\4\0\0=\4\25\3=\3 \2B\0\2\1K\0\1\0\20inactive_winbar\1\2\1\0\rfilename\tpath\3\3\1\0\0\22inactive_sections\1\2\2\0\rfilename\tpath\3\3\ncolor\vLineNr\1\0\0\rsections\14lualine_z\14lualine_y\14lualine_x\14lualine_c\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\foptions\1\0\0\23section_separators\1\0\2\nright\5\tleft\5\frefresh\1\0\3\vwinbar\3d\ftabline\3d\15statusline\3d\17ignore_focus\23disabled_filetypes\vwinbar\1\2\0\0\rNvimTree\15statusline\1\0\0\25component_separators\1\0\2\nright\5\tleft\5\1\0\4\25always_divide_middle\2\ntheme\tauto\18icons_enabled\2\17globalstatus\2\nsetup\flualine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  neoformat = {
    config = { "\27LJ\2\nQ\0\0\5\0\6\0\b6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0\19:Neoformat<CR>\14<leader>m\6n\bset\vkeymap\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n­\6\0\0\5\0$\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0029\0\a\0005\2\n\0005\3\b\0005\4\t\0>\4\2\3=\3\v\0025\3\f\0005\4\r\0>\4\2\3=\3\14\0025\3\15\0005\4\16\0>\4\2\3=\3\17\0025\3\18\0005\4\19\0>\4\2\3=\3\20\0025\3\21\0005\4\22\0>\4\2\3=\3\23\0025\3\24\0005\4\25\0>\4\2\3=\3\26\0025\3\27\0005\4\28\0>\4\2\3=\3\29\0025\3\30\0005\4\31\0>\4\2\3=\3 \0025\3!\0005\4\"\0>\4\2\3=\3#\2B\0\2\1K\0\1\0\azb\1\2\0\0\a50\1\2\0\0\azb\azz\1\2\0\0\a50\1\2\0\0\azz\azt\1\2\0\0\a50\1\2\0\0\azt\n<C-e>\1\5\0\0\t0.10\nfalse\a50\16'quadratic'\1\2\0\0\vscroll\n<C-y>\1\5\0\0\n-0.10\nfalse\a50\16'quadratic'\1\2\0\0\vscroll\n<C-f>\1\5\0\0#vim.api.nvim_win_get_height(0)\ttrue\a50\16'quadratic'\1\2\0\0\vscroll\n<C-b>\1\5\0\0$-vim.api.nvim_win_get_height(0)\ttrue\a50\16'quadratic'\1\2\0\0\vscroll\n<C-d>\1\5\0\0\18vim.wo.scroll\ttrue\a50\16'quadratic'\1\2\0\0\vscroll\n<C-u>\1\0\0\1\5\0\0\19-vim.wo.scroll\ttrue\a50\16'quadratic'\1\2\0\0\vscroll\17set_mappings\21neoscroll.config\rmappings\1\n\0\0\n<C-u>\n<C-d>\n<C-b>\n<C-f>\n<C-y>\n<C-e>\azt\azz\azb\1\0\5\21performance_mode\1\25cursor_scrolls_alone\1\22respect_scrolloff\2\rstop_eof\2\16hide_cursor\1\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp_luasnip", "cmp-buffer", "cmp-path" },
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireú\4\0\2\t\0\29\0`5\2\0\0=\1\1\0026\3\2\0009\3\3\0039\3\4\3\18\5\1\0'\6\5\0'\a\6\0B\3\4\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\n\0006\a\2\0009\a\v\a9\a\f\a9\a\r\a\18\b\2\0B\3\5\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\14\0006\a\2\0009\a\v\a9\a\f\a9\a\15\a\18\b\2\0B\3\5\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\16\0006\a\2\0009\a\v\a9\a\f\a9\a\17\a\18\b\2\0B\3\5\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\18\0006\a\2\0009\a\19\a9\a\20\aB\3\4\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\21\0006\a\2\0009\a\v\a9\a\f\a9\a\22\a\18\b\2\0B\3\5\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\23\0006\a\2\0009\a\v\a9\a\f\a9\a\24\a\18\b\2\0B\3\5\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\25\0006\a\2\0009\a\v\a9\a\f\a9\a\26\a\18\b\2\0B\3\5\0016\3\2\0009\3\a\0039\3\b\3'\5\t\0'\6\27\0006\a\2\0009\a\v\a9\a\f\a9\a\28\a\18\b\2\0B\3\5\1K\0\1\0\20type_definition\agt\15references\agr\19implementation\agi\nhover\agh\15open_float\15diagnostic\age\15definition\agd\vrename\15<leader>rn\16code_action\bbuf\blsp\n<C-.>\6n\bset\vkeymap\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvim\vbuffer\1\0\2\fnoremap\2\vsilent\2„\15\1\0\15\0d\0è\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\3B\1\2\0016\1\0\0'\3\t\0B\1\2\0029\1\3\0015\3\n\0005\4\v\0=\4\f\3B\1\2\0019\1\3\0005\3\16\0005\4\14\0003\5\r\0=\5\15\4=\4\17\0039\4\18\0009\4\19\0049\4\20\0045\6\22\0009\a\18\0009\a\21\aB\a\1\2=\a\23\0069\a\18\0009\a\24\a)\tüÿB\a\2\2=\a\25\0069\a\18\0009\a\26\aB\a\1\2=\a\27\0069\a\18\0009\a\24\a)\t\4\0B\a\2\2=\a\28\0069\a\18\0009\a\29\aB\a\1\2=\a\30\0069\a\18\0009\a\31\aB\a\1\2=\a \0069\a\18\0009\a!\a5\t\"\0B\a\2\2=\a#\6B\4\2\2=\4\18\0039\4$\0009\4%\0044\6\5\0005\a&\0>\a\1\0065\a'\0>\a\2\0065\a(\0>\a\3\0065\a)\0>\a\4\6B\4\2\2=\4%\0035\4-\0006\5\0\0'\a*\0B\5\2\0029\5+\0055\a,\0B\5\2\2=\5.\4=\4/\3B\1\2\0016\0010\0009\0011\0019\1$\0015\0032\0B\1\2\0015\0013\0006\0024\0\18\4\1\0B\2\2\4H\5\f€'\a5\0\18\b\5\0&\a\b\a6\b0\0009\b6\b9\b7\b\18\n\a\0005\v8\0=\0069\v=\a:\v=\a;\vB\b\3\1F\5\3\3R\5ò\1276\2\0\0'\4<\0B\2\2\0029\2=\2B\2\1\0023\3>\0006\4\0\0'\6?\0B\4\2\0029\4@\4'\6A\0B\4\2\0026\5\0\0'\aB\0B\5\2\0029\5C\0059\5\3\0055\aD\0=\2E\a=\3F\a=\4G\a5\bS\0005\tK\0005\nI\0005\vH\0=\vJ\n=\nL\t5\nP\0004\v\0\b6\f0\0009\f6\f9\f\15\f'\14M\0B\f\2\2+\r\2\0<\r\f\v6\f0\0009\f6\f9\fN\f'\14$\0B\f\2\2'\rO\0&\f\r\f+\r\2\0<\r\f\v=\vQ\n=\nR\t=\tT\b=\bU\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5V\0059\5\3\0055\aW\0=\2E\a=\3F\a=\4G\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5X\0059\5\3\0055\aY\0=\2E\a=\3F\a=\4G\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5Z\0059\5\3\0055\a[\0=\2E\a=\3F\a=\4G\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5\\\0059\5\3\0055\a]\0=\2E\a=\3F\a=\4G\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5^\0059\5\3\0055\a_\0=\2E\a=\3F\a=\4G\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5`\0059\5\3\0055\aa\0=\2E\a=\3F\a=\4G\aB\5\2\0016\5\0\0'\aB\0B\5\2\0029\5b\0059\5\3\0055\ac\0=\2E\a=\3F\a=\4G\aB\5\2\1K\0\1\0\1\0\0\vyamlls\1\0\0\fpyright\1\0\0\vjsonls\1\0\0\thtml\1\0\0\veslint\1\0\0\ncssls\1\0\0\rtsserver\rsettings\bLua\1\0\0\14workspace\flibrary\1\0\0\t/lua\fstdpath\20$VIMRUNTIME/lua\16diagnostics\1\0\0\fglobals\1\0\0\1\2\0\0\bvim\rroot_dir\14on_attach\17capabilities\1\0\0\16sumneko_lua\14lspconfig\t.git\17root_pattern\19lspconfig.util\0\25default_capabilities\17cmp_nvim_lsp\nnumhl\vtexthl\ttext\1\0\0\16sign_define\afn\19DiagnosticSign\npairs\1\0\4\tInfo\bï‘‰\tHint\bï µ\tWarn\bï”©\nError\bï™™\1\0\1\17virtual_text\1\15diagnostic\bvim\15formatting\vformat\1\0\0\1\0\2\rmaxwidth\0032\tmode\vsymbol\15cmp_format\flspkind\1\0\2\19keyword_length\3\4\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-p>\21select_prev_item\n<C-n>\21select_next_item\n<C-f>\n<C-e>\nabort\n<C-b>\16scroll_docs\14<C-Space>\1\0\0\rcomplete\vinsert\vpreset\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\21ensure_installed\1\t\0\0\ncssls\veslint\thtml\vjsonls\fpyright\16sumneko_lua\rtsserver\vyamlls\1\0\1\27automatic_installation\2\20mason-lspconfig\aui\1\0\0\nicons\1\0\0\1\0\3\20package_pending\bâžœ\22package_installed\bâœ“\24package_uninstalled\bâœ—\nsetup\nmason\bcmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nÈ\6\0\0\a\0&\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0005\4\15\0=\4\16\0035\4\17\0005\5\19\0005\6\18\0=\6\v\5=\5\20\4=\4\21\3=\3\22\0025\3\23\0=\3\24\2B\0\2\0016\0\25\0009\0\26\0009\0\27\0'\2\28\0'\3\29\0'\4\30\0B\0\4\0016\0\25\0009\0\26\0009\0\27\0'\2\28\0'\3\31\0'\4 \0B\0\4\0016\0\25\0009\0!\0'\2\"\0B\0\2\0016\0\25\0009\0!\0'\2#\0B\0\2\0016\0\25\0009\0!\0'\2$\0B\0\2\0016\0\25\0009\0!\0'\2%\0B\0\2\1K\0\1\0)highlight! clear NvimTreeEndOfBuffer'highlight! clear NvimTreeVertSplit$highlight! clear NvimTreeNormal1highlight! link NvimTreeIndentMarker Comment\bcmd\30<CMD>NvimTreeFindFile<CR>\14<LEADER>j\28<CMD>NvimTreeToggle<CR>\f<C-S-j>\6n\bset\vkeymap\bvim\tview\1\0\1\nwidth\3(\rrenderer\nicons\vglyphs\1\0\0\1\0\a\14untracked\bï‘\runmerged\bîœ§\fignored\bï‘¨\vstaged\bï„‘\fdeleted\6-\runstaged\bï„Œ\frenamed\bï•“\1\0\1\18git_placement\nafter\19indent_markers\1\0\1\venable\2\1\0\1\17indent_width\3\2\24update_focused_file\1\0\1\15update_cwd\1\bgit\1\0\2\venable\2\vignore\2\factions\1\0\2\20respect_buf_cwd\2\15update_cwd\1\14open_file\1\0\0\18window_picker\1\0\0\1\0\1\venable\1\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÔ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\21ensure_installed\1\0\2\17auto_install\2\17sync_install\1\1\3\0\0\btsx\15typescript\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    config = { "\27LJ\2\n”\1\0\0\3\0\b\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\4\0B\0\1\0016\0\5\0009\0\6\0'\2\a\0B\0\2\1K\0\1\0 highlight! clear FoldColumn\bcmd\bvim\tload\1\0\1\nstyle\tdark\nsetup\fonedark\frequire\0" },
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
  ["promise-async"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nÔ\a\0\0\v\0/\0R6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\22\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0035\5\r\0005\6\a\0005\a\5\0>\a\1\0065\a\6\0=\a\b\0065\a\t\0=\a\n\0065\a\v\0=\a\f\6=\6\14\0055\6\19\0005\a\15\0006\b\0\0'\n\16\0B\b\2\0029\b\17\b=\b\18\a=\a\20\6=\6\21\5B\3\2\2=\3\23\0025\3\25\0005\4\24\0=\4\26\3=\3\27\0025\3\29\0005\4\28\0=\4\30\3=\3\31\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0 \0'\2\26\0B\0\2\0016\0!\0009\0\"\0009\0#\0'\2$\0'\3%\0'\4&\0B\0\4\0016\0!\0009\0\"\0009\0#\0'\2$\0'\3'\0'\4(\0B\0\4\0016\0!\0009\0\"\0009\0#\0'\2$\0'\3)\0'\4*\0B\0\4\0016\0!\0009\0\"\0009\0#\0'\2$\0'\3+\0'\4,\0B\0\4\0016\0!\0009\0\"\0009\0#\0'\2$\0'\3-\0'\4.\0B\0\4\1K\0\1\0\29:Telescope git_files<CR>\14<LEADER>g\30:Telescope find_files<CR>\14<LEADER>f\28:Telescope oldfiles<CR>\14<LEADER>e\27:Telescope builtin<CR>\14<LEADER>b\28:Telescope commands<CR>\14<LEADER>a\6n\bset\vkeymap\bvim\19load_extension\fpickers\roldfiles\1\0\0\1\0\1\ronly_cwd\2\15extensions\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\14case_mode\15smart_case\25override_file_sorter\2\nfuzzy\2\rdefaults\1\0\0\rmappings\6i\1\0\0\n<esc>\nclose\22telescope.actions\1\0\1\n<C-u>\1\16borderchars\1\0\1\fpreview\1\fpreview\1\t\0\0\bâ”€\bâ”‚\bâ”€\bâ”‚\bâ”Œ\bâ”\bâ”˜\bâ””\fresults\1\t\0\0\bâ”€\bâ”‚\bâ”€\bâ”‚\bâ”œ\bâ”¤\bâ”˜\bâ””\vprompt\1\0\0\1\t\0\0\bâ”€\bâ”‚\6 \bâ”‚\bâ”Œ\bâ”\bâ”‚\bâ”‚\1\t\0\0\bâ”€\bâ”‚\bâ”€\bâ”‚\bâ”Œ\bâ”\bâ”˜\bâ””\17get_dropdown\21telescope.themes\nsetup\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nR\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\25use_diagnostic_signs\2\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-fugitive"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-matchup"] = {
    after_files = { "/Users/albertos/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/albertos/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp_nvim_lsp"] = "cmp-nvim-lsp",
  ["^lspconfig"] = "nvim-lspconfig",
  ["^lspkind"] = "lspkind.nvim",
  ["^luasnip"] = "LuaSnip",
  ["^mason"] = "mason.nvim",
  ["^mason%-lspconfig"] = "mason-lspconfig.nvim",
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

-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0\17TroubleClose\18NvimTreeClose\17NeoTreeClose\nonly!\bcmd\bvimp\1\0\5\0\6\0\v3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0004\4\3\0>\0\1\4=\4\5\3B\1\2\1K\0\1\0\18pre_save_cmds\1\0\1\14log_level\nerror\nsetup\17auto-session\frequire\0\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: onedark.nvim
time([[Config for onedark.nvim]], true)
try_loadstring("\27LJ\2\n”\1\0\0\3\0\b\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\4\0B\0\1\0016\0\5\0009\0\6\0'\2\a\0B\0\2\1K\0\1\0 highlight! clear FoldColumn\bcmd\bvim\tload\1\0\1\nstyle\tdark\nsetup\fonedark\frequire\0", "config", "onedark.nvim")
time([[Config for onedark.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au User Defer ++once lua require("packer.load")({'lspsaga.nvim', 'nvim-autopairs', 'neoscroll.nvim', 'trouble.nvim', 'lualine.nvim', 'nvim-colorizer.lua', 'Comment.nvim', 'nvim-tree.lua', 'nvim-treesitter', 'nvim-cmp', 'neoformat', 'telescope.nvim', 'nvim-surround', 'vim-fugitive', 'leap.nvim', 'better-escape.nvim', 'gitsigns.nvim', 'indent-blankline.nvim', 'vim-matchup'}, { event = "User Defer" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

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
