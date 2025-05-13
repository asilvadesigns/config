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

# c && c++
set -gx CPATH "/opt/homebrew/include"
set -gx LIBRARY_PATH "/opt/homebrew/lib"
set -gx PATH "/usr/local/include" $PATH;

# fzf
source $HOME/.config/fish/themes/base16-solarized-light.fish
# source $HOME/.config/fish/themes/base16-solarized-dark

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

# Created by `pipx` on 2024-02-28 18:49:16
set PATH $PATH /Users/albertos/.local/bin

# direnv
direnv hook fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# atuin
atuin init fish --disable-up-arrow | source

# zoxide
zoxide init fish | source

# starship must be at the end
starship init fish | source
