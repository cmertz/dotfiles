# make `ctrl-d` work when partial command is typed already
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# close idle shells after 30min
export TMOUT=1800
readonly TMOUT
export TMOUT
