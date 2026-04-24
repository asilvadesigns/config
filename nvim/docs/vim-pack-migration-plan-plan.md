  # lazy.nvim Evaluation and vim.pack Migration Doc

  ## Summary

  Create a checked-in guide at nvim/docs/vim-pack-migration.md that does two things:

  - Evaluates your current lazy.nvim usage against Neovim v0.12.0’s built-in vim.pack
  - Recommends a conservative, phased migration path instead of an immediate replacement

  The guide should explicitly state that vim.pack is available in Neovim 0.12.0 but is still documented as experimental, so the migration decision is about reducing dependency
  surface and complexity, not gaining feature parity.

  ## Evaluation Findings To Capture

  Document these repo-specific conclusions up front:

  - Your config is a good migration candidate because plugin config is already centralized in init.lua and most behavior lives in plain Lua modules under lua/config/plugins.
  - You use a moderate subset of lazy.nvim features:
    cmd, keys, event, ft, dependencies, build, priority, version, branch, url, name, and the lazy-lock.json lockfile.
  - You do not appear to rely on advanced lazy features like plugin imports, scoped spec trees, or heavy dynamic spec generation, which lowers migration risk.
  - You do rely on lazy in a few concrete places that must be replaced or called out:
    init.lua bootstraps lazy.nvim directly
    lua/config/plugins/persistence.lua reads lazy.core.config internals to check plugin load state
    lua/config/plugins/snacks.lua exposes :Lazy and DepsUpdate in the dashboard / command palette
    performance.rtp.disabled_plugins is currently handled by lazy, so equivalent runtime trimming must be moved to native Neovim settings
  - The guide should note one likely cleanup item: event = "User ExtraLazy" / event = "User SuperLazy" patterns are present, but the matching autocmd emitters
are commented out in
    init.lua, so these events are not currently part of a clean native loading story.

  ## Document Structure and Decisions

  Write the migration doc with these sections:

  - Title and recommendation
    State that the recommended path is “phase in vim.pack, keep rollback easy, do not delete lazy.nvim until native loading and update workflows are proven”.
  - Current state
    Summarize current plugin count and loading style, and list the lazy-specific mechanisms you use today.
  - Feature mapping
    Include a table mapping:
    lazy.nvim bootstrap -> vim.pack.add()
    lazy-lock.json -> nvim-pack-lock.json
    cmd / keys / ft / event lazy-loading -> manual :packadd or explicit vim.pack.add(..., { load = ... }) strategy plus user autocmds/keymaps
    dependencies -> explicit add/load ordering in Lua
    build hooks -> PackChanged autocmd hooks
    :Lazy UI -> no native equivalent
    performance.rtp.disabled_plugins -> direct native startup configuration
  - Migration design
    Standardize on a native layout where plugin specs live in one Lua module, use vim.pack.add() with explicit names/sources/versions, and keep plugin config
modules unchanged
    wherever possible.
    Recommend converting always-on plugins first, then command/key/filetype-triggered plugins, and leaving the most lazy-specific UX pieces for last.
  - Repo-specific blockers
    Specify exact replacements:
    remove lazy.nvim bootstrap from init.lua
    replace lazy.core.config load checks in persistence.lua with a native check based on command availability, module availability, or plugin path activity
    replace :Lazy and DepsUpdate menu items in snacks.lua with native maintenance actions or remove them
    replace performance.rtp.disabled_plugins with equivalent native startup settings
  - Phased rollout
    Phase 1: create the doc and native spec shape without changing behavior
    Phase 2: migrate always-loaded plugins and lockfile workflow
    Phase 3: migrate lazily-triggered plugins with explicit native loading hooks
    Phase 4: remove lazy.nvim only after startup, session restore, treesitter build/update, and dashboard actions are validated
  - Rollback guidance
    Keep lazy-lock.json and the old bootstrap path until the native path is stable
    State that rollback is just restoring the old bootstrap and spec block

  ## Public Interfaces / Behavior To Define

  The doc should make these implementation choices explicit so a later implementer does not need to decide them:

  - New doc path: nvim/docs/vim-pack-migration.md
  - Native package manager source of truth: one vim.pack.add() declaration module, not scattered calls
  - Lockfile to track in git after migration: nvim-pack-lock.json
  - Build/update hooks to use: PackChanged autocmds for plugins like Treesitter that currently use build = ":TSUpdate"
  - Lazy-load strategy under vim.pack:
    always-on plugins are loaded immediately
    command/key/filetype plugins are loaded via explicit wrappers/autocmds, not by trying to recreate all lazy.nvim semantics implicitly
  - Dashboard/command-palette maintenance entry points should target native package actions, not :Lazy

  ## Test Plan

  The document should include acceptance checks for a later migration:

  - Startup reaches a clean UI on nvim --clean-style local config launch with no missing plugin errors
  - Session save/restore still works, including the nvim-tree close-on-exit path
  - Command-triggered plugins still load on first use:
    Trouble, Mason, Neogit, formatter commands, search commands
  - Key-triggered plugins still load on first use:
    surround, hlslens, smart-splits, treesj, gitsigns, leap
  - Filetype-triggered plugins still activate for Lua, JS/TS, HTML, and templ buffers
  - Treesitter parsers still install/update correctly under native hooks
  - Dashboard and command palette no longer expose broken :Lazy / DepsUpdate entries
  - Lockfile-driven reinstall works on a second machine or fresh data directory

  ## Assumptions

  - Target Neovim version is exactly v0.12.0 or newer.
  - The document should recommend a conservative phased migration, not an immediate cutover.
  - The document should live in-repo as Markdown.
  - Official Neovim vim.pack behavior, lockfile, and PackChanged events should be treated as the primary reference for the guide.

