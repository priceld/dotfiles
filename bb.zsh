export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# postgres
# This is the default data dir when using Posgres.app
export PGDATA="~/work/pg-data/Postgres/var-14"

export GIT_ROOT=$HOME/work/learn
export PATH=$PATH:$GIT_ROOT/bin
# NOTE to future self: this next source call really seem to add a lot of time to the shell startup time
# And it does so for things I don't use very often (such as startLearn). I wonder if I can get rid of
# this and use direnv to source it when I enter the learn directory.
source $HOME/work/learn.util/sourceall.sh
source $HOME/scripts/current_sp.sh

# Zscaler cert for node.
export NODE_EXTRA_CA_CERTS=~/work/zscaler-certs/ZscalerRootCA.pem
if [ ! -f "$NODE_EXTRA_CA_CERTS" ]; then
  echo "!!! Could not find Zscaler Root CA certificate !!!"
fi

# Setup direnv hook for ZSH
eval "$(direnv hook zsh)"

ultra-on() {
  # May need to call ~/work/bb/blackboard/tools/admin/UpdateUltraUIDecision.sh first
  psql -d BBLEARN_GIT -U postgres -a -1 -f ~/work/learn.util/users/logan.price/enable-ultra.sql
}

# Setup asdf (for kubectl)
source /opt/homebrew/opt/asdf/libexec/asdf.sh
export KUBECONFIG=~/.kube/config


# Back to my own stuff:
function calogin() {
    export CODEARTIFACT_FNDS_AUTH_TOKEN=`aws codeartifact get-authorization-token --region us-east-1 --domain packages --domain-owner 159633141984 --query authorizationToken --output text`
}

# Load worktree helpers
source $HOME/work/dotfiles/worktrees.sh

# Watch a PR to see when its checks finish
# TODO: make this a gh extension
# Or just us tmux notify for this?
watch-pr() {
  local pr=$1
  gh pr checks $pr --watch --fail-fast --required -i 60
  if [[ $? -eq 0 ]]; then
    terminal-notifier -title "PR Checks Successful!" -message "Checks for PR $pr succeeded."
  else
    terminal-notifier -title "PR Checks Failed" -message "Checks for PR $pr failed."
  fi
}

# Github Copilot CLI aliases.
alias '??'='gh copilot suggest -t shell'
alias 'git?'='gh copilot suggest -t git'
alias 'gh?'='gh copilot suggest -t gh'

alias 'ff'="$HOME/work/dotfiles/toggle-ff.sh"
