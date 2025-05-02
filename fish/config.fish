export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim
export MANPAGER="nvim +Man!"
export MANWIDTH=999

abbr --add nr 'npm run $(fp)'

# npm run $(fp)
function fp
  echo $(cat package.json | jq '.scripts | keys[]' | fzf --reverse | sed 's/"//g')
end

# bat
set -gx BAT_CONFIG_PATH "$HOME/.config/bat/bat.conf"

# fish
set -g fish_greeting;

# ghost
if set -q GHOSTTY_RESOURCES_DIR
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

# vi mode
set fish_vi_key_bindings;
set fish_cursor_default block;
set fish_cursor_insert line;
set fish_cursor_replace_one underscore;
set fish_cursor_replace underscore;
set fish_cursor_external line;
set fish_cursor_visual block;

# Setting this because fish's fish_vi_cursor is not detecting ghostty's term capabilities
set fish_vi_force_cursor

# vi mode copy/paste @see: https://github.com/fish-shell/fish-shell/issues/4028
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

# fzf (THEME: https://github.com/catppuccin/fzf)
# frappe (DARK)
# set -gx FZF_DEFAULT_OPTS "\
# --color=bg+:#414559,bg:#292c3c,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
# --color=border:#292c3c"

# latte (LIGHT)
# set -gx FZF_DEFAULT_OPTS "\
# --color=bg+:#ccd0da,bg:#e6e9ef,spinner:#dc8a78,hl:#d20f39 \
# --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
# --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
# --color=border:#e6e9ef"
set -gx FZF_DEFAULT_OPTS "--color=border:blue,bg+:-1"

# c && c++
set -gx CPATH "/opt/homebrew/include"
set -gx LIBRARY_PATH "/opt/homebrew/lib"
set -gx PATH "/usr/local/include" $PATH;

# go
set -gx GOPATH "$HOME/go"
set -gx PATH "$GOPATH/bin" $PATH;

# pnpm
set -gx PNPM_HOME "/Library/pnpm";
set -gx PATH $PNPM_HOME $PATH;

# python
set -gx PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" $PATH;
set -gx PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" $PATH;

# neovim
set -gx PATH "$HOME/.local/share/nvim/mason/bin" $PATH;

# fnm
set -gx PATH "$HOME/Library/Caches/fnm_multishells/39562_1707258676146/bin" $PATH;
set -gx FNM_DIR "$HOME/Library/Application Support/fnm";
set -gx FNM_RESOLVE_ENGINES "false";
set -gx FNM_MULTISHELL_PATH "$HOME/Library/Caches/fnm_multishells/39562_1707258676146";
set -gx FNM_LOGLEVEL "info";
set -gx FNM_VERSION_FILE_STRATEGY "local";
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -gx FNM_COREPACK_ENABLED "false";
set -gx FNM_ARCH "arm64";

# yarn
# set -gx YARN_GLOBAL_FOLDER "$FNM_MULTISHELL_PATH/yarn-global"
# set -gx YARN_PREFIX "$FNM_MULTISHELL_PATH"

# Created by `pipx` on 2024-02-28 18:49:16
set PATH $PATH /Users/albertos/.local/bin

# direnv
direnv hook fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# atuin
atuin init fish --disable-up-arrow | source

# starship must be at the end but we're trying PURE right now...
starship init fish | source
