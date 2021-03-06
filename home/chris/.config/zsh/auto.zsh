# delayed sourcing of files
#
# This exists mainly because my autocomplete setups add up
# in startup time and push the time to start `zsh` to
# nearly 2 seconds.
#
# It deliberately does not use any clean room approach since
# we want things in our shell. In principle this allows for
# all kinds of setup before a command or when entering a directory.
#
#
# 1. generation of lazy loading proxy functions
#
#    This generates a proxy function for all files in `$_auto_dir`
#    for which a command exists in `$PATH`.
#
#    Those functions self delete when they first execute.
#
#
# 2. sourcing of files depending on the working directory
#
#    An example config looks like:
#    ```
#       _auto=(
#         "/home/chris/kubernetes" "kubectl helm"
#         "/home/chris/google-cloud" "kubectl helm gcloud"
#         "/home/chris/aws" "aws kubectl helm gcloud"
#       )
#    ```
#
#    The script sources the configs in all `auto_*.zsh` files sorts them
#    and merges them. The same keys in later files override earlier ones.
#

_auto_dir=${_auto_dir:-${HOME}/.config/zsh/auto}

# proxy functions
for auto in $(ls $_auto_dir -1 | sed "s#$_auto_dir/##g")
do
  if [[ $command[$auto] == "" ]]
  then
    continue
  fi

  function $auto() {
    unfunction $auto
    echo "zsh: source ${auto}"
    source $_auto_dir/$auto
    $0 "$@"
  }
done

# auto sourcing on cd
typeset -gA _auto_lookup
export _auto_lookup

for preset in $(ls ${HOME}/.config/zsh/auto_*.zsh -1 | sort | xargs)
do
  typeset -A _auto
  export _auto

  source $preset

  for dir in $(print -l -- ${(k)_auto})
  do
    _auto_lookup[$dir]=$_auto[$dir]
  done

  unset _auto
done

function chpwd() {
  emulate -L zsh

  local keep=()

  for auto in $(echo $_auto_lookup[$PWD] | sed "s/ /\n/g" | sort)
  do
    if [[ ! -f "$_auto_dir/$auto" ]]
    then
      echo "zsh: file not found ($_auto_dir/$auto)"
      keep=($keep $auto)
      continue
    fi

    if typeset -f $auto > /dev/null
    then
      unfunction $auto
    fi

    echo "zsh: source ${auto}"
    source "$_auto_dir/$auto"
  done

  _auto_lookup[$PWD]=$keep
}

