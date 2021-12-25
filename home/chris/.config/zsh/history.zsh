setopt hist_ignore_all_dups
setopt share_history
setopt inc_append_history
setopt hist_verify
setopt hist_ignore_space

source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

alias h='history 1'
