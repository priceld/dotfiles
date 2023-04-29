cat << EOS >> ~/.config/direnv/direnvrc
# Based on https://github.com/direnv/direnv/wiki/Node
# This allows .envrc scripts to use "use nvm VERSION"
use_nvm() {
  local node_version=$1
  local nvm=$(which nvm)
  if [[ -n $nvm && $? -eq 0 ]]; then
    nvm use $node_version
    exit $?
  fi
   
  local nvm_source=~/.nvm/nvm.sh
  if [[ -e $nvm_source ]]; then
    source $nvm_source
    nvm use $node_version
  else
    echo "Could not find nvm."
  fi
}
EOS