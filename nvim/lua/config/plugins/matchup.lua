---@diagnostic disable: missing-fields
local M = {}

M.config = function()
  -- This option controls whether matching is done within strings and comments.
  -- By default, it is set to 0 which means all valid matches are made within
  -- strings and comments.  If set to 1, symbols like `()` will still be matched
  -- but words like `for` and `end` will not.  If set to 2, nothing will be
  -- matched within strings and comments.
  vim.g.matchup_delim_noskips = 1

  -- Enable deferred highlighting for better performance
  vim.g.matchup_matchparen_deferred = 1

  -- Delay before showing highlight
  vim.g.matchup_matchparen_deferred_show_delay = 50

  -- Disable fallback to Vim's built-in matchparen
  vim.g.matchup_matchparen_fallback = 0

  -- Always highlight surrounding delimiters
  vim.g.matchup_matchparen_hi_surround_always = 0

  -- Timeout for finding matches (in ms)
  vim.g.matchup_matchparen_timeout = 150

  -- Timeout for insert mode (in ms)
  vim.g.matchup_matchparen_insert_timeout = 60

  -- Disable off-screen match display
  vim.g.matchup_matchparen_offscreen = {}

  -- Limit lines searched for matches
  vim.g.matchup_matchparen_stopline = 50

  -- Disable enhanced motions like %, [%, ]%
  vim.g.matchup_motion_enabled = 0

  -- Override vimtex's matching in LaTeX files
  vim.g.matchup_override_vimtex = 1

  -- Enable surrounding functionality
  vim.g.matchup_surround_enabled = 0

  -- Disable text objects like i%, a%
  vim.g.matchup_text_obj_enabled = 0

  vim.g.matchup_matchpref = {
    html = { tagnameonly = 1 },
    javascriptreact = { tagnameonly = 1 },
    svelte = { tagnameonly = 1 },
    typescriptreact = { tagnameonly = 1 },
    vue = { tagnameonly = 1 },
  }
end

return M
