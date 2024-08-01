local M = {}

M.setup = function()
  vim.g.matchup_matchparen_offscreen = {
    method = "popup",
  }

  vim.g.matchup_delim_nomids = 1
  vim.g.matchup_delim_noskips = 2

  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_hi_surround_always = 1

  vim.g.matchup_override_vimtex = 1

  vim.g.matchup_treesitter_text_obj_enabled = 0

  vim.g.matchup_delim_start_plaintext = "([{<"
  vim.g.matchup_delim_end_plaintext = ")]}>."
end

return M
