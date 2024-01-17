if status is-interactive
    # Commands to run in interactive sessions can go here
end

function bb
  set -l branch (git branch --all | fzf --reverse | tr -d `[:space:]`) 
  echo "checking out... $branch"
  git checkout $branch
end

function gg
  set -l directory (ls -1 ~/dev | fzf --reverse)
  cd ~/dev/$directory/
end

set -gx EDITOR nvim

starship init fish | source

# fish
set -g fish_greeting

# pnpm
set -gx PNPM_HOME "~/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# python
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

# smart tmux session
fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
