if status is-interactive
    # Commands to run in interactive sessions can go here
end

function gch
  set -l branch (git branch --all | fzf --reverse | tr -d `[:space:]`) 
  echo "checking out... $branch"
  git checkout $branch
end

function go
  set -l directory (ls -1 ~/dev | fzf --reverse)
  cd ~/dev/$directory/
end

set -gx EDITOR nvim

starship init fish | source

# pnpm
set -gx PNPM_HOME "~/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
# Setting PATH for Python 3.11
# The original version is saved in /Users/albertos/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
