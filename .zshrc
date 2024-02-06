# https://github.com/dreamsofcode-io/dotfiles/blob/main/.zshrc

# Uncomment to add profiling to zsh startup
# You can then run zprof to see the most time consuming parts of startup
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit && compinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light ohmyzsh/ohmyzsh
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit snippet OMZP::git

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

export LANG=en_US.UTF-8

# Leaving this here so I can investigate it later.
# source $HOME/.config/tmuxinator/tmuxinator.zsh

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

# P10k customizations
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

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

# From: https://sgeb.io/posts/bash-zsh-half-typed-commands/
bindkey '^q' push-line-or-edit

export WORK_HOME="$HOME/work"
# Load work stuff
[ -f "$WORK_HOME/learn.util/users/logan.price/bb.zsh" ] && source "$WORK_HOME/learn.util/users/logan.price/bb.zsh"

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
