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
  echo $(cat package.json | jq '.scripts | keys[]' | fzf | sed 's/"//g')
end

starship init fish | source

# fish
set -g fish_greeting

# pnpm
set -gx PNPM_HOME "~/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# python
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
