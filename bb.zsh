export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# postgres
# This is the default data dir when using Posgres.app
export PGDATA="~/work/pg-data/Postgres/var-14"

export GIT_ROOT=$HOME/work/learn
export PATH=$PATH:$GIT_ROOT/bin
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
  psql -d BBLEARN_GIT -U postgres -a -1 -f ~/work/learn.util/users/logan.price/enable-ultra.sql
}

# Setup asdf (for kubectl)
source /opt/homebrew/opt/asdf/libexec/asdf.sh
export KUBECONFIG=~/.kube/config


# Back to my own stuff:
function calogin() {
    export CODEARTIFACT_FNDS_AUTH_TOKEN=`aws codeartifact get-authorization-token --region us-east-1 --domain packages --domain-owner 159633141984 --query authorizationToken --output text`
}
