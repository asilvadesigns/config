export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

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
set -g fish_greeting

# pnpm
set -x PNPM_HOME "~/Library/pnpm"
set -x PATH $PNPM_HOME $PATH

# python
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" $PATH

# fnm
# NOTE: this is setup with fnm completions --shell fish
set -x PATH "~/Library/Caches/fnm_multishells/18173_1707157997977/bin" $PATH;
set -x FNM_DIR "~/Library/Application Support/fnm";
set -x FNM_LOGLEVEL "info";
set -x FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -x FNM_RESOLVE_ENGINES "false";
set -x FNM_MULTISHELL_PATH "~/Library/Caches/fnm_multishells/18173_1707157997977";
set -x FNM_COREPACK_ENABLED "false";
set -x FNM_VERSION_FILE_STRATEGY "local";
set -x FNM_ARCH "arm64";
