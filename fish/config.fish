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