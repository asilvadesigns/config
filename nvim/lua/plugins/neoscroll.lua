local M = {}

M.setup = function()
  require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    --
    cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil, -- Default easing function
    hide_cursor = false, -- Hide cursor while scrolling
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    performance_mode = false, -- Disable "Performance Mode" on all buffers.
    respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
  })

  require('neoscroll.config').set_mappings({
    -- Syntax: t[keys] = {function, {function arguments}}
    -- ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '350', [['sine']] } },
    -- ['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '500', [['circular']] } },
    --
    -- Use the "sine" easing function
    ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '50', [['quadratic']] } },
    ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '50', [['quadratic']] } },
    -- Use the "circular" easing function
    ['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '50', [['quadratic']] } },
    ['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '50', [['quadratic']] } },
    -- Pass "nil" to disable the easing animation (constant scrolling speed)
    ['<C-y>'] = { 'scroll', { '-0.10', 'false', '50', [['quadratic']] } },
    ['<C-e>'] = { 'scroll', { '0.10', 'false', '50', [['quadratic']] } },
    -- When no easing function is provided the default easing function (in this case "quadratic") will be used
    ['zt'] = { 'zt', { '50' } },
    ['zz'] = { 'zz', { '50' } },
    ['zb'] = { 'zb', { '50' } },
  })
end

return M
