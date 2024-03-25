export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

abbr --add nr 'npm run $(fp)'

function bb
  set -l branch (git branch --all | fzf --reverse | tr -d `[:space:]`) 
  echo "checking out... $branch"
  git checkout $branch
end

function gg
  set -l directory (ls -1 ~/dev | fzf --reverse)
  cd ~/dev/$directory/
end

# npm run $(fp)
function fp
  echo $(cat package.json | jq '.scripts | keys[]' | fzf --reverse | sed 's/"//g')
end

starship init fish | source

# bat
set -gx BAT_CONFIG_PATH "$HOME/.config/bat/bat.conf"

# fish
set -g fish_greeting;

# fzf (THEME: https://github.com/catppuccin/fzf)
# frappe (DARK)
# set -gx FZF_DEFAULT_OPTS "\
# --color=bg+:#414559,bg:#292c3c,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
# --color=border:#292c3c"

# latte (LIGHT)
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#ccd0da,bg:#e6e9ef,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
--color=border:#e6e9ef"

# go
set -gx GOPATH "$HOME/go"
set -gx PATH "$GOPATH/bin" $PATH;

# pnpm
set -gx PNPM_HOME "/Library/pnpm";
set -gx PATH $PNPM_HOME $PATH;

# python
set -gx PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" $PATH;
set -gx PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" $PATH;

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
set -gx YARN_GLOBAL_FOLDER "$FNM_MULTISHELL_PATH/yarn-global"
set -gx YARN_PREFIX "$FNM_MULTISHELL_PATH"

# Created by `pipx` on 2024-02-28 18:49:16
set PATH $PATH /Users/albertos/.local/bin
