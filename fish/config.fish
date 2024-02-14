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

# fish
set -g fish_greeting;

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
