export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim
export MANWIDTH=999

set -gx MANPAGER "nvim +Man!"

# gum
set -gx GUM_FILTER_INDICATOR_FOREGROUND "4"
set -gx GUM_FILTER_MATCH_FOREGROUND "4"

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

# libomp
set -gx LIBOMP_PREFIX "/opt/homebrew/opt/libomp"

# vulkan
set -gx VK_ICD_FILENAMES "/opt/homebrew/etc/vulkan/icd.d/MoltenVK_icd.json"
set -gx VK_LAYER_PATH "/opt/homebrew/opt/vulkan-validationlayers/share/vulkan/explicit_layer.d"

# set -gx PATH "/opt/homebrew/opt/llvm@17/bin" $PATH;
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm@17/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm@17/include"

# fzf @see: https://github.com/tinted-theming/tinted-fzf
source $HOME/.config/fish/themes/base16-solarized-light.fish

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

# rust
set -gx PATH "$HOME/.cargo/bin" $PATH;

# bun
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH

# atuin
atuin init fish --disable-up-arrow | source

# direnv
direnv hook fish | source


# zoxide
zoxide init fish | source

# starship
starship init fish | source

# NOTE: the following came from stdout after `brew install sqlite`
# If you need to have sqlite first in your PATH, run:
#   fish_add_path /opt/homebrew/opt/sqlite/bin
#
# For compilers to find sqlite you may need to set:
#   set -gx LDFLAGS "-L/opt/homebrew/opt/sqlite/lib"
#   set -gx CPPFLAGS "-I/opt/homebrew/opt/sqlite/include"
#
# For pkg-config to find sqlite you may need to set:
#   set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/sqlite/lib/pkgconfig"

