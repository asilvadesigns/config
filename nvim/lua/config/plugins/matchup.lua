local M = {}

M.setup = function()
  vim.g.matchup_matchparen_enabled = 1
  vim.g.matchup_motion_enabled = 0
  vim.g.matchup_surround_enabled = 0
  vim.g.matchup_text_obj_enabled = 0
  vim.g.matchup_transmute_enabled = 0

  vim.g.matchup_matchparen_deferred = 1 -- improve scrolling performance
  vim.g.matchup_matchparen_deferred_hide_delay = 16
  vim.g.matchup_matchparen_deferred_show_delay = 16
  -- vim.g.matchup_matchparen_stopline = 300 -- " for match highlighting only
  -- adjust timeout for highlighting
  -- vim.g.matchup_matchparen_insert_timeout = 100
  -- vim.g.matchup_matchparen_timeout = 1000

  vim.g.matchup_matchparen_offscreen = {
    method = "popup",
  }
  --
  -- vim.g.matchup_delim_nomids = 1
  -- 1 recognize symbols in comments
  -- 2 ignore comments
  vim.g.matchup_delim_noskips = 2
  --
  -- vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_hi_surround_always = 1
  --
  -- vim.g.matchup_override_vimtex = 1
  --
  -- vim.g.matchup_treesitter_text_obj_enabled = 0
  --
  -- vim.g.matchup_delim_start_plaintext = "([{<"
  -- vim.g.matchup_delim_end_plaintext = ")]}>."
end

return M
