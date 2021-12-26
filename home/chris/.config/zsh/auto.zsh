# Create dynamic proxy functions that will delete themselves upon
# first invocation. This can be useful to source heavy things like
# completions in a lazy manner.
#
# inspired by
#   https://frederic-hemberger.de/notes/shell/speed-up-initial-zsh-startup-with-lazy-loading/
#

readonly _proxy_dir=$XDG_CONFIG_HOME/zsh/lazy

# make non-matching glob a noop
setopt null_glob

for cmd in $_proxy_dir/*
do
  # create a function with the filename
  function $(basename $cmd) {
    unfunction $0
    source $_proxy_dir/$0
    $0 "$@"
  }
done

unsetopt null_glob
