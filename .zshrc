# https://github.com/dreamsofcode-io/dotfiles/blob/main/.zshrc

# Uncomment to add profiling to zsh startup
# You can then run zprof to see the most time consuming parts of startup
# zmodload zsh/zprof

# Hardcoding homebrew path because $(brew --prefix) is slow
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
# This is from omz's lib/completion.zsh. I don't know why it is needed except
# that it defines/loads "complete"
autoload -U +X bashcompinit && bashcompinit

# Disable highlighting on paste
zle_highlight=('paste:none')

# lazygit needs this var exported in order to look under .config/lazygit for
# the global config file
export XDG_CONFIG_HOME="$HOME/.config"

# Similarly, this is how to manually configure the up/down arrow functionality
# from ohmyzsh (e.g. type + search up in history) without using ohmyzsh.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

export LANG=en_US.UTF-8

setopt auto_cd

if (( $+commands[kubectl] )) {
  # Placeholder for lazy loading. Will only be called once.
  kubectl() {
    unfunction "$0"
    # Completions
    source <(kubectl completion zsh)

    # Invoke kubectl
    $0 "$@"
  }
}

# from: https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup fnm ZSH hooks to trigger on CD
eval "$(fnm env --use-on-cd)"

# Enable VI-mode
bindkey -v

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# From: https://sgeb.io/posts/bash-zsh-half-typed-commands/
bindkey '^Q' push-line
# NOTE: in order for Ctrl+q to work, flow control has to be turned off. This is
# generally considered fine when using local terminals, but may need to turn it
# off (stty ixon) if connecting to other devices over a serial connection.
# OR maybe I should just pick a different shortcut...
stty -ixon

export WORK_HOME="$HOME/work"
LEARN_UTIL_PROFILE_ROOT="$WORK_HOME/learn.util/users/logan.price"
if [ ! -d "$LEARN_UTIL_PROFILE_ROOT" ]; then
  echo "!!!!! WARNING !!!!!"
  echo "Learn util profile root does not exist: $LEARN_UTIL_PROFILE_ROOT"
fi
# Load work stuff
[ -f "$LEARN_UTIL_PROFILE_ROOT/bb.zsh" ] && source "$LEARN_UTIL_PROFILE_ROOT/bb.zsh"

export EDITOR=nvim

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
if (( $+commands[bun] )) {
  # Lazy loading, will only be called once
  bun() {
    unfunction "$0"
    # bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

    $0 "$@"
  }
}

# TODO fix this path to make it more robust
export PATH="$WORK_HOME/dotfiles/bin:$PATH"

# Set the theme to use for bat
export BAT_THEME="1337"
# This is making fzf break in nvim and not show any preview at all. Not sure why.
#export FZF_PREVIEW_COMMAND="bat"
#

# I don't like having this...I really only need it for Aladdin tests.
# TODO: check out https://docs.astral.sh/uv/
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
[ $+commands[pyenv] ] || export PATH="$PYENV_ROOT/bin:$PATH"
if (( $+commands[pyenv] )) {
  pyenv() {
    unfunction "$0"
    eval "$(pyenv init -)"

    $0 "$@"
  }
}

# From Jason's config
if (( $+commands[eza] )) {
  # change file owner to yellow instead of bold yellow
  export EZA_COLORS="uu=33"
  # format times like file modified time as ISO instead of dynamic which is too variable
  # list [a]ll files in a [l]ong listing with column [h]eaders and include git status info if any
  alias la='eza -ahl --git --group-directories-first'
  alias ll='eza -hl --git --group-directories-first --no-user'
}

# I wasn't able to lazy load this easily for some reason
eval "$(zoxide init zsh)"
function zd() {
  # This is a special case for zoxide to work better in worktrees. The idea is
  # that zoxide will help find the appropriate relative directory and
  # proximity-sort will ensure that it is within the current worktree.
  \builtin cd -- "$(zoxide query --list $@ | proximity-sort $(pwd) | head -n 1)"
}

# Strips all the ANSI color codes from the input
# Based on: https://stackoverflow.com/questions/17998978/removing-colors-from-output
alias stripcolors='sed -E "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g"'
# Have difft show a "unified" diff. The goal is to get this to work in vim-fugitive
alias inlinedifft='difft --display inline'

# ZSH history
# Where to store the history file (by default it is not written to a file)
export HISTFILE="$HOME/.zsh_history"
# The maximum number of events stored in the internal history list.
export HISTSIZE=100000
# The maximum number of history events to save in the history file.
export SAVEHIST=100000

setopt HIST_IGNORE_DUPS # Don't record duplicates in the history
setopt HIST_IGNORE_SPACE # Don't record commands starting with a space
setopt SHARE_HISTORY # Share history between all sessions

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

source $HOME/.zsh/aliases
source $HOME/.zsh/functions

if [[ -z "$NO_PROMPT" ]]; then
  source $HOME/.zsh/wincent-prompt
fi

# I'm tired of using a package manager because they make everything slow. So
# loading zsh-syntax-highlighting manually.
# source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
