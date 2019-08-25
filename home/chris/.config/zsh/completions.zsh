# autocompletion
setopt noautomenu
setopt nocorrect

# proxy function for kubectl to load
# autocompletion lazily
kubectl() {
  unfunction "$0"
  source <(kubectl completion zsh)
  $0 "$@"
}

# proxy function for minikube to load
# autocompletion lazily
minikube() {
  unfunction "$0"
  source <(minikube completion zsh)
  $0 "$@"
}

# proxy function for helm to load
# autocompletion lazily
helm() {
  unfunction "$0"
  source <(helm completion zsh)
  $0 "$@"
}

# proxy function for minikube to load
# autocompletion lazily
gcloud() {
  unfunction "$0"
  source /opt/google-cloud-sdk/completion.zsh.inc
  $0 "$@"
}

# proxy function for docker to load
# autocompletion lazily
docker() {
  unfunction "$0"
  source /usr/share/zsh/site-functions/_docker
  zstyle ':completion:*:*:docker:*' option-stacking yes
  zstyle ':completion:*:*:docker-*:*' option-stacking yes
  $0 "$@"
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

