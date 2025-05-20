#!/bin/sh

if [ -n "$TMUX" ]; then
  cmd=$(tmux display -p '#{pane_current_command}')
  if [ "$cmd" = "vim" ] || [ "$cmd" = "nvim" ]; then
    tmux display-message "Cannot clear in Vim."
    exit
  fi
  tmux send-keys -R \; send-keys C-l
else
  # Not in tmux – just clear the screen
  printf '\033c'
fi
