---@diagnostic disable: missing-fields
local M = {}

M.init = function()
  vim.g.matchup_delim_noskips = 2 -- Ignore matches in comments and strings
  vim.g.matchup_matchparen_deferred = 1 -- Enable deferred highlighting for better performance
  -- vim.g.matchup_matchparen_deferred_hide_delay = 50  -- Delay before hiding highlight
  vim.g.matchup_matchparen_deferred_show_delay = 30 -- Delay before showing highlight
  vim.g.matchup_matchparen_fallback = 0 -- Disable fallback to Vim's built-in matchparen
  vim.g.matchup_matchparen_hi_surround_always = 1 -- Always highlight surrounding delimiters
  vim.g.matchup_matchparen_timeout = 300 -- Timeout for finding matches (in ms)
  vim.g.matchup_matchparen_insert_timeout = 60 -- Timeout for insert mode (in ms)
  vim.g.matchup_matchparen_offscreen = {} -- Disable off-screen match display
  vim.g.matchup_matchparen_stopline = 50 -- Limit lines searched for matches
  vim.g.matchup_motion_enabled = 0 -- Disable enhanced motions like %, [%, ]%
  vim.g.matchup_override_vimtex = 1 -- Override vimtex's matching in LaTeX files
  vim.g.matchup_surround_enabled = 1 -- Enable surrounding functionality
  vim.g.matchup_text_obj_enabled = 0 -- Disable text objects like i%, a%
  vim.o.matchpairs = "(:),{:},[:],<:>" -- Set matching pairs, including angle brackets
end

M.setup = function()
  require("nvim-treesitter.configs").setup({
    matchup = {
      enabled = true,
      include_match_words = false,
    },
  })
end

return M
