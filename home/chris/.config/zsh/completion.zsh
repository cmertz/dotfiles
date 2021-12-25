autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# from https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${HOME}/.cache/zsh/.zcompcache
zstyle ':completion:*' completer _extensions _expand_alias _complete
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-list all
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true
