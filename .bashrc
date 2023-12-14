# NOTES
#
# Shell - changing default shell
# @see: https://www.shell-tips.com/mac/upgrade-bash/#gsc.tab=0
#
# Shell - startup order
# @see: http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
#
# Shell - upgrading bash MacOS
# @see: https://clubmate.fi/upgrade-to-bash-4-in-mac-os-x
#
# Bash history - remove duplicates
# awk '!x[$0]++' ~/.bash_history                 # keep the first value repeated.
# tac ~/.bash_history | awk '!x[$0]++' | tac     # keep the last.
export HISTCONTROL=ignoreboth:erasedups

# FZF
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Personal
# source ~/.scripts/abrev.sh
source ~/.scripts/alias.sh

function cc() {
  cd ~/dev && cd $(ls -1 | fzf)
}

function branch() {
  git checkout $(git branch --sort=-committerdate | fzf)
}

eval "$(starship init bash)"

eval "$(zoxide init bash)"

