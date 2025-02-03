local M = {}

M.setup = function()
  require("smear_cursor").setup({
    cursor_color = "#e78284",
    stiffness = 0.6,
    trailing_stiffnewss = 0.1,
    trailing_exponent = 5,
    gamma = 1,
    --
    -- cursor_color = "#e78284",
    -- time_interval = 17,
    -- max_slope_horizontal = 0.5,
    -- min_slope_vertical = 2,
    -- gamma = 2.2,
    -- color_levels = 16,
    -- distance_stop_animating = 0.1,
    -- stiffness = 0.6,
    -- trailing_stiffnewss = 0.3,
    -- trailing_exponent = 0.1,
  })
end

return M
